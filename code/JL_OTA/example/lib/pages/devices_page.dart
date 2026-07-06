import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jl_ota/ble_event_stream.dart';
import 'package:jl_ota/ble_method.dart';
import 'package:jl_ota_example/l10n/app_localizations.dart';
import 'package:jl_ota/model/device_connection.dart';
import 'package:jl_ota/model/scan_device.dart';
import 'package:jl_ota_example/utils/app_util.dart';
import 'package:provider/provider.dart';
import 'package:jl_ota/constant/ble_event_constants.dart';
import 'package:jl_ota/constant/constants.dart';
import '../data/dialog_manager.dart';
import '../dialog/loading_dialog.dart';
import '../utils/share_preference.dart';
import '../widgets/device_filter_widget.dart';
import '../widgets/connect_list.dart';
import '../utils/data_notifier.dart';

/// UI Constants
class DevicesPageUIConstants {
  static const double appBarTitleSize = 18;
  static const double spacingSmall = 10;
  static const int delayMilliseconds = 500;
  static const int connectionTimeoutSeconds = 15;
}

/// Color Constants
class DevicesPageColorConstants {
  static const Color primaryTextColor = Color(0xFF242424);
  static const Color backgroundColor = Colors.white;
}

/// Method Channel Constants
class MethodChannelConstants {
  static const String channelName = 'com.jieli.ble_plugin/methods';
}

/// Regular Expression Constants
class RegexConstants {
  static const String macAddressPattern = r'[0-9A-Fa-f:]+';
  static const String addressGroupName = 'address';
  static const String addressPattern = '$addressGroupName: ($macAddressPattern)';
}

/// OTA State Constants
class OtaStateConstants {
  static const String keyState = BleEventConstants.KEY_STATE;
  static const String keyStateUnknown = BleEventConstants.KEY_STATE_UNKNOWN;
  static const String keyStateWorking = BleEventConstants.KEY_STATE_WORKING;
}

/// Scan State Constants
class ScanStateConstants {
  static const String stateScanning = BleEventConstants.SCAN_STATE_SCANNING;
  static const String stateIdle = BleEventConstants.SCAN_STATE_IDLE;
}

/// Device Management Page
///
/// Responsible for operations such as scanning, connecting, and disconnecting Bluetooth devices. Main functionalities include:
/// - Displaying a list of available Bluetooth devices
/// - Supporting device name filtering and search
/// - Handling device connection status changes
/// - Managing scan lifecycle
/// - Displaying connection loading status
class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> with WidgetsBindingObserver {
  String _filterContent = "";
  List<ScanDevice> _devices = [];
  bool _isLoading = true;

  StreamSubscription<List<ScanDevice>>? _scanSubscription;
  StreamSubscription<DeviceConnection>? _deviceConnectionSubscription;
  StreamSubscription<Map<String, dynamic>>? _otaConnectionSubscription;
  StreamSubscription<String>? _scanStateSubscription;
  StreamSubscription? _otaStateSubscription;

  late DialogManager _dialogManager;

  final MethodChannel _methodChannel = MethodChannel(
    MethodChannelConstants.channelName,
  );

  bool _isOtaDialogShown = false;
  bool _isDialogLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.connect,
          style: const TextStyle(
            color: DevicesPageColorConstants.primaryTextColor,
            fontSize: DevicesPageUIConstants.appBarTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: DevicesPageColorConstants.backgroundColor,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _restartScan,
        child: Column(
          children: [
            const SizedBox(height: DevicesPageUIConstants.spacingSmall),
            DeviceFilterWidget(
              filterContent: _filterContent,
              onFilterChanged: _handleFilterChanged,
            ),
            const SizedBox(height: DevicesPageUIConstants.spacingSmall),
            Expanded(
              child: ConnectListView(
                devices: _filteredDevices,
                isShowLoading: _isLoading,
                onTap: _handleDeviceTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _restartScan();
    }
  }

  @override
  void dispose() {
    _cleanupResources();
    super.dispose();
  }

  void _initializeApp() async {
    await _loadFilterContent();
    _setupEventListeners();
    _startScan();
    _initData();
  }

  Future<void> _loadFilterContent() async {
    try {
      final content = await FilePreferenceManager.loadFilterContent();
      if (mounted) {
        setState(() {
          _filterContent = content;
        });
      }
    } catch (e) {
      log("Failed to load filter content: $e");
    }
  }

  void _setupEventListeners() {
    _subscribeToScanListStream();
    _subscribeToScanStateStream();
    _subscribeToDeviceConnectionStream();
    _subscribeToOtaConnectionStream();
    _subscribeToOtaStateStream();
  }

  void _initData() {
    _dialogManager = DialogManager(
      context: context,
      methodChannel: _methodChannel,
    );
  }

  void _cleanupResources() {
    _scanSubscription?.cancel();
    _deviceConnectionSubscription?.cancel();
    _otaConnectionSubscription?.cancel();
    _scanStateSubscription?.cancel();
    _otaStateSubscription?.cancel();

    BleMethod.stopScan();

    WidgetsBinding.instance.removeObserver(this);
  }

  List<ScanDevice> convertToScanDeviceList(List<dynamic> list) {
    return list.map((item) {
      if (item is ScanDevice) {
        return item;
      } else if (item is Map) {
        return ScanDevice.fromMap(item);
      } else {
        throw Exception('Unsupported type: ${item.runtimeType}');
      }
    }).toList();
  }

  void _subscribeToScanListStream() {
    _scanSubscription = BleEventStream.scanDeviceListStream.listen(
      _handleScanDeviceListUpdate,
    ) as StreamSubscription<List<ScanDevice>>?;
  }

  void _handleScanDeviceListUpdate(List<dynamic> devices) {
    if (!mounted) return;

    final convertedDevices = convertToScanDeviceList(devices);
    setState(() => _devices = convertedDevices);
  }

  void _subscribeToScanStateStream() {
    _scanStateSubscription = BleEventStream.scanStateStream.listen(
          (state) {
        if (!mounted) return;

        setState(() {
          if (state == ScanStateConstants.stateScanning) {
            _isLoading = true;
          } else if (state == ScanStateConstants.stateIdle) {
            _isLoading = false;
          }
        });
      },
      onError: (error) {
        log("Scan state stream error: $error");
      },
    );
  }

  Future<void> _restartScan() async {
    _stopScan();
    _startScan();

    Future.delayed(Duration(milliseconds: DevicesPageUIConstants.delayMilliseconds), () {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  Future<void> _stopScan() async {
    try {
      await BleMethod.stopScan();
    } catch (e) {
      log("Failed to stop scan: $e");
    }
  }

  void _startScan() async {
    if (!mounted) return;
    await BleMethod.startScan();
  }

  void _subscribeToDeviceConnectionStream() {
    _deviceConnectionSubscription = BleEventStream.deviceConnectionStream
        .listen(
          (connection) async {
        log("Device connection status: ${connection.state}");

        if (connection.state == AppConstants.connectionConnecting) {
          if (mounted && !_isDialogLoading) {
            await LoadingDialog.showLoadingDialog(
              context,
              timeoutSeconds: DevicesPageUIConstants.connectionTimeoutSeconds,
            );
            _isDialogLoading = true;
          }
        } else {
          if (mounted && Navigator.canPop(context)) {
            await LoadingDialog.hideLoadingDialog();
          }
          _isDialogLoading = false;
        }
      },
      onError: (error) {
        log("Device connection stream error: $error");
      },
    ) as StreamSubscription<DeviceConnection>?;
  }

  void _handleDeviceTapped(ScanDevice device) {
    final deviceAddress = _extractAddressFromDescription(device.description);

    int index;

    if (deviceAddress != null) {
      index = _devices.indexWhere((d) {
        final dAddress = _extractAddressFromDescription(d.description);
        return dAddress == deviceAddress;
      });
    } else {
      index = _devices.indexWhere((d) => d.description == device.description);
    }

    if (index == -1) return;

    if (device.isOnline) {
      _disconnectBtDevice(index);
    } else {
      _connectToDevice(index);
    }
  }

  void _connectToDevice(int index) async {
    try {
      await BleMethod.connectDevice(index);
    } catch (e) {
      log("Failed to connect to device: $e");
    }
  }

  void _disconnectBtDevice(int index) async {
    try {
      await BleMethod.disconnectBtDevice(index);
    } catch (e) {
      log("Failed to disconnect from device: $e");
    }
  }

  List<ScanDevice> get _filteredDevices {
    final Map<String, ScanDevice> uniqueDevices = {};

    for (final device in _devices) {
      final address = _extractAddressFromDescription(device.description);
      final key = address ?? device.name;

      if (!uniqueDevices.containsKey(key)) {
        uniqueDevices[key] = device;
      }
    }

    final distinctDevices = uniqueDevices.values.toList();

    if (_filterContent.isEmpty) return distinctDevices;

    return distinctDevices.where((device) {
      return device.name.toLowerCase().contains(_filterContent.toLowerCase());
    }).toList();
  }

  void _handleFilterChanged(String value) {
    setState(() {
      _filterContent = value;
    });
  }

  String? _extractAddressFromDescription(String description) {
    final addressPattern = RegExp(RegexConstants.addressPattern);
    final match = addressPattern.firstMatch(description);
    return match?.group(RegexCaptureGroups.address);
  }

  void _subscribeToOtaConnectionStream() {
    _otaConnectionSubscription = BleEventStream.otaConnectionStream.listen(
          (otaData) {
        if (mounted) {
          Provider.of<DataNotifier>(context, listen: false).setOtaData(otaData);
        }
      },
      onError: (error) {
        log("OTA connection stream error: $error");
      },
    );
  }

  void _subscribeToOtaStateStream() {
    if (AppUtil.isIOS) {
      _otaStateSubscription = BleEventStream.otaStateStream.listen(
            (otaData) {
          if (mounted) {
            setState(() {
              updateOtaState(otaData);
            });
          }
        },
      );
    }
  }

  void updateOtaState(Map<String, dynamic> otaData) {
    if (!mounted) return;

    final newOtaState =
        otaData[OtaStateConstants.keyState] as String? ??
            OtaStateConstants.keyStateUnknown;

    switch (newOtaState) {
      case OtaStateConstants.keyStateWorking:
        if (!_isOtaDialogShown) {
          setState(() {
            _isOtaDialogShown = true;
          });

          _dialogManager.showOtaDialog().then((_) {
            if (mounted) {
              setState(() {
                _isOtaDialogShown = false;
              });
            }
          });
        }
        break;
    }
  }
}

class RegexCaptureGroups {
  static const int address = 1;
}
