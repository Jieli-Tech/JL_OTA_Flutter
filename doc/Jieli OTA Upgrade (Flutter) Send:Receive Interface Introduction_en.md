# Jieli OTA Upgrade (Flutter) Send/Receive Interface Introduction

| Version   | Update Date  | Update Content   | 
|:-------|:-----------|:-----------|
| V1.1.0 | 2026/07/03 | Android:<br>1.Added support for special upgrade process with reuse space.<br>2.Added BLE auto-reconnection support for single-backup OTA.<br>3.Added Gatt Over BR/EDR connection method support.<br>4. Added custom commands.<br>IOS:<br>1.Fixed OTA reconnection timeout issue.<br>2.Added Gatt Over BR/EDR connection method support.<br>3.Added custom commands.| 
| V1.0.0 | 2025/11/19 | Initial release |

## Overview

The Jieli OTA Upgrade APP is an online upgrade tool designed specifically for devices using Jieli chips. It allows users to perform firmware upgrades on devices via Bluetooth, ensuring that devices always have the latest features and security fixes.


## 1. Dart Send Layer Interfaces(ble_method.dart)

### 1.1 Initialize MethodChannel

```dart
  static const MethodChannel _methodChannel = MethodChannel(
    'com.jieli.ble_plugin/methods',
  );
```
### 1.2 Start Scanning

```dart
    static Future<void> startScan() async {
    try {
      await _methodChannel.invokeMethod(BleMethodConstants.METHOD_START_SCAN);
    } on PlatformException catch (e) {
      print("Failed to start scan: ${e.message}");
      rethrow;
    }
  }

  Usage Example：await BleMethod.startScan();  
```

### 1.3 Stop Scanning

```dart
   static Future<void> stopScan() async {
    try {
      await _methodChannel.invokeMethod(BleMethodConstants.METHOD_STOP_SCAN);
    } on PlatformException catch (e) {
      print("Failed to stop scan: ${e.message}");
      rethrow;
    }
  }

  Usage Example：await BleMethod.stopScan();
```

### 1.4 Connect Device

```dart
  static Future<void> connectDevice(int index) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_CONNECT_DEVICE,
        {BleMethodConstants.ARG_INDEX: index},
      );
    } on PlatformException catch (e) {
      print("Failed to connect device at index $index: ${e.message}");
      rethrow;
    }
  }

  Usage Example：
  /// Connect to a device at the specified index
  void _connectToDevice(int index) async {
    try {
      await BleMethod.connectDevice(index);
    } catch (e) {
      log("Failed to connect to device: $e");
      // Optionally show an error message to the user
    }
  }
```

### 1.5 Disconnect Device

```dart
    static Future<void> disconnectBtDevice(int index) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_DISCONNECT_BT_DEVICE,
        {BleMethodConstants.ARG_INDEX: index},
      );
    } on PlatformException catch (e) {
      print("Failed to disconnect device at index $index: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
    /// Disconnect from a device at the specified index
  void _disconnectBtDevice(int index) async {
    try {
      await BleMethod.disconnectBtDevice(index);
    } catch (e) {
      log("Failed to disconnect from device: $e");
      // Optionally show an error message to the user
    }
  }
```

### 1.6 Get Current Communication Method (Android)

```dart
  static Future<int> getConnectWay() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_GET_CONNECT_WAY,
          ) ??
          true;
    } on PlatformException catch (e) {
      print("Failed to check if BLE way is used: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getConnectWay();
```

### 1.7 Set Current Communication Method(Android)

```dart
  static Future<void> setConnectWay(int connectWay) async {
    try {
      await _methodChannel.invokeMethod(BleMethodConstants.METHOD_SET_CONNECT_WAY, {
        BleMethodConstants.ARG_CONNECT_WAY: connectWay,
      });
    } on PlatformException catch (e) {
      print("Failed to set BLE way: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  int communicationMethod = AppConstants.communicationWayBle;
  await BleMethod.setConnectWay(communicationMethod);
```

### 1.8 Check if Using SDK Bluetooth(IOS)

```dart
  static Future<bool> isUseSdkBluetooth() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_IS_USING_SDK_BLUETOOTH,
          ) ??
          true;
    } on PlatformException catch (e) {
      print("Failed to check if sdk bluetooth is used: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.isUseSdkBluetooth();
```

### 1.9 Set Whether to Use SDK Bluetooth(IOS)
```dart
  static Future<void> setConnectUsingSdkBluetooth(bool isUsingSDKBluetooth) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_USING_SDK_BLUETOOTH,
        {BleMethodConstants.ARG_IS_USING_SDK_BLUETOOTH: isUsingSDKBluetooth},
      );
    } on PlatformException catch (e) {
      print("Failed to use sdk bluetooth: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.setConnectUsingSdkBluetooth(true);
```

### 1.10 Check if Using GattOverEdr(IOS)

```dart
  static Future<bool> isUseGattOverEdr() async {
    try {
      return await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_IS_USING_GATT_OVER_EDR,
      ) ??
          true;
    } on PlatformException catch (e) {
      print("Failed to check if sdk bluetooth is used: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.isUseGattOverEdr();
```

### 1.11 Set Whether to Use GattOverEdr(IOS)

```dart
  static Future<void> setGattOverEdrState(bool gattOverEdrState) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_GATT_OVER_EDR,
        {BleMethodConstants.ARG_IS_USING_GATT_OVER_EDR: gattOverEdrState},
      );
    } on PlatformException catch (e) {
      print("Failed to set gatt over edr: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  bool gattOverEdr = true;
  await BleMethod.setGattOverEdrState(gattOverEdr);
```

### 1.12 Get Gatt Service Uuids(IOS)

```dart
  static Future<List<String>> getGattServiceUuids() async {
    try {
      final result = await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_GET_GATT_SERVICE_UUIDS,
      );
      return List<String>.from(result ?? []);
    } on PlatformException catch (e) {
      print("Failed to get gatt service uuids: ${e.message}");
      return [];
    }
  }

  Usage Example:await BleMethod.getGattServiceUuids();
```

### 1.13 Set Gatt Service Uuids(IOS)

```dart
  static Future<void> setGattServiceUuids(List<String> uuids) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_GATT_SERVICE_UUIDS,
        {BleMethodConstants.ARG_GATT_SERVICE_UUIDS: uuids},
      );
    } on PlatformException catch (e) {
      print("Failed to set gatt servie uuids: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  List<String> gattServiceUuids = ["AE00"];
  await BleMethod.setGattServiceUuids(gattServiceUuids);
```

### 1.14 Check if Device Authentication is Required (Android and iOS)
```dart
    static Future<bool> isUseDeviceAuth() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_IS_USE_DEVICE_AUTH,
          ) ??
          true;
    } on PlatformException catch (e) {
      print(
        "Failed to check if device authentication is used: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.isUseDeviceAuth();
```

### 1.15 Set Whether Device Authentication is Required (Android and iOS)
```dart
  static Future<void> setUseDeviceAuth(bool isAuth) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_USE_DEVICE_AUTH,
        {BleMethodConstants.ARG_IS_AUTH: isAuth},
      );
    } on PlatformException catch (e) {
      print("Failed to set device authentication: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.setUseDeviceAuth(true);
```

### 1.16 Check if Current Device is HID Device (Android)
```dart
  static Future<bool> isHidDevice() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_IS_HID_DEVICE,
          ) ??
          false;
    } on PlatformException catch (e) {
      print("Failed to check if HID device: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.isHidDevice();
```

### 1.17 Set Whether Current Device is HID Device (Android)
```dart
  static Future<void> setHidDevice(bool isHid) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_HID_DEVICE,
        {BleMethodConstants.ARG_IS_HID: isHid},
      );
    } on PlatformException catch (e) {
      print("Failed to set HID device: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.setHidDevice(true);
```

### 1.18 Check if Using Custom Reconnection Method (Android)
```dart
  static Future<bool> isUseCustomReConnectWay() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_IS_USE_CUSTOM_RECONNECT_WAY,
          ) ??
          false;
    } on PlatformException catch (e) {
      print(
        "Failed to check if custom reconnect way is used: ${e.message}"
      );
      rethrow;
    }
  }

  Usage Example:await BleMethod.isUseCustomReConnectWay();
```

### 1.19 Set Whether to Use Custom Reconnection Method (Android)
```dart
  static Future<void> setUseCustomReConnectWay(bool isCustom) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_USE_CUSTOM_RECONNECT_WAY,
        {BleMethodConstants.ARG_IS_CUSTOM: isCustom},
      );
    } on PlatformException catch (e) {
      print("Failed to set custom reconnect way: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.setUseCustomReConnectWay(true);
```

### 1.20 Get Current BLE MTU Request Value (Android)
```dart
  static Future<int> getBleRequestMtu() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_GET_BLE_REQUEST_MTU,
          ) ??
          0;
    } on PlatformException catch (e) {
      print("Failed to get BLE MTU: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getBleRequestMtu();
```

### 1.21 Set BLE MTU Request Value (Range: 23~509) (Android)
```dart
  static Future<void> setBleRequestMtu(int mtu) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_BLE_REQUEST_MTU,
        {BleMethodConstants.ARG_MTU: mtu},
      );
    } on PlatformException catch (e) {
      print("Failed to set BLE MTU: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.setBleRequestMtu(500);
```

### 1.22 Get SDK Version
```dart
  static Future<String> getSdkVersion() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_GET_SDK_VERSION,
          ) ??
          'V?.?.?(?)';
    } on PlatformException catch (e) {
      print("Failed to get SDK version: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getSdkVersion();
```

### 1.23 Get APP Version
```dart
  static Future<String> getAppVersion() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_GET_APP_VERSION,
          ) ??
          'V?.?.?(?)';
    } on PlatformException catch (e) {
      print("Failed to get APP version: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getAppVersion();
```

### 1.24 Get Log File Directory Path
```dart
  static Future<String> getLogFileDirPath() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_GET_LOG_FILE_DIR_PATH,
          ) ??
          '';
    } on PlatformException catch (e) {
      print("Failed to get log file directory path: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getLogFileDirPath();
```

### 1.25 Get Log File List
```dart
  static Future<void> getLogFiles() async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_GET_LOG_FILES,
      );
    } on PlatformException catch (e) {
      print("Failed to get log files: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.getLogFiles();
```

### 1.26 Click Log File List Index
```dart
  static Future<void> clickLogFileIndex(int logFileIndex) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_LOG_FILE_INDEX,
        {BleMethodConstants.ARG_LOG_FILE_INDEX: logFileIndex},
      );
    } on PlatformException catch (e) {
      print(
        "Failed to click log file index $logFileIndex: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.clickLogFileIndex(1); // 1: Current log file index
```

### 1.27 Delete All Log Files
```dart
  static Future<bool> deleteAllLogFiles() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_DELETE_ALL_LOG_FILE,
          ) ??
          false;
    } on PlatformException catch (e) {
      print("Failed to delete all log files: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.deleteAllLogFiles();
```

### 1.28 Share Log File
```dart
  static Future<void> shareLogFile(int logFileIndex) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SHARE_LOG_FILE,
        {BleMethodConstants.ARG_LOG_FILE_INDEX: logFileIndex},
      );
    } on PlatformException catch (e) {
      print(
        "Failed to share log file at index $logFileIndex: ${e.message}");
      rethrow;
    }
  }

  Usage Example:await BleMethod.shareLogFile(2); // 2: Current log file index
```

### 1.29 Download File
```dart
  static Future<void> downloadFile(String httpUrl) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_DOWNLOAD_FILE,
        {BleMethodConstants.ARG_HTTP_URL: httpUrl},
      );
    } on PlatformException catch (e) {
      print("Failed to download file from $httpUrl: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  String httpUrl = '' // httpUrl is the download link
  await BleMethod.downloadFile(httpUrl);
```

### 1.30 Check if OTA is in Progress
```dart
  static Future<bool> isOTA() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_TYPE_IS_OTA,
          ) ??
          true;
    } on PlatformException catch (e) {
      print("Failed to get Ota state: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.isOTA();
```

### 1.31 Read OTA File List
```dart
  static Future<void> readFileList() async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_READ_FILE_LIST,
      );
    } on PlatformException catch (e) {
      print("Failed to read OTA file list: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.readFileList();
```

### 1.32 Set Selected OTA File Index
```dart
  static Future<void> setSelectedIndex(int pos) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SET_SELECTED_INDEX,
        {BleMethodConstants.ARG_POS: pos},
      );
    } on PlatformException catch (e) {
      print("Failed to set selected index $pos: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.setSelectedIndex(1); // 1:Currently selected upgrade file index
```

### 1.33 Delete Selected OTA File Index
```dart
  static Future<void> deleteOtaIndex(int pos) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_DELETE_OTA_FILE_INDEX,
        {BleMethodConstants.ARG_POS: pos},
      );
    } on PlatformException catch (e) {
      print("Failed to delete OTA file index $pos: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.deleteOtaIndex(1); // 1:Currently selected upgrade file index to delete
```

### 1.34 Check External Storage Permission Environment
```dart
  static Future<bool> tryToCheckStorageEnvironment() async {
    try {
      return await _methodChannel.invokeMethod(
            BleMethodConstants.METHOD_TRY_TO_CHECK_STORAGE_ENVIRONMENT,
          ) ??
          false;
    } on PlatformException catch (e) {
      print("Failed to check storage environment: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.tryToCheckStorageEnvironment();
```

### 1.35 Pick File
```dart
  static Future<void> pickFile() async {
    try {
      await _methodChannel.invokeMethod(BleMethodConstants.METHOD_PICK_FILE);
    } on PlatformException catch (e) {
      print("Failed to pick file: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.pickFile();
```

### 1.36 Start OTA Update
```dart
  static Future<void> startOTA(String path) async {
    try {
      await _methodChannel.invokeMethod(
          BleMethodConstants.METHOD_START_OTA,
          {BleMethodConstants.ARG_PATH: path}
      );
    } on PlatformException catch (e) {
      print("Failed to start OTA: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  String path = '' // path is the OTA upgrade file storage path
  await BleMethod.startOTA(path);
```

### 1.37 Get WiFi IP Address (Return format: "http://[ip]:[port]")
```dart
  static Future<String> getWifiIpAddress() async {
    try {
      final String? ipAddress = await _methodChannel.invokeMethod<String>(
        BleMethodConstants.METHOD_GET_WIFI_IP_ADDRESS,
      );
      return ipAddress ?? 'Failed to get WiFi IP address';
    } on PlatformException catch (e) {
      print("Failed to get WiFi IP address: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.getWifiIpAddress();
```

### 1.38 Pop All Activities
```dart
  static Future<void> popAllActivity() async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_POP_ALL_ACTIVITY,
      );
    } on PlatformException catch (e) {
      print("Failed to pop all activities: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  await BleMethod.popAllActivity();
```

### 1.39 Send Custom Command
```dart
  static Future<void> sendCustomCommand(Uint8List data) async {
    try {
      await _methodChannel.invokeMethod(
        BleMethodConstants.METHOD_SEND_CUSTOM_COMMAND,
        {BleMethodConstants.ARG_CUSTOM_DATA: data},
      );
    } on PlatformException catch (e) {
      print("Failed to send custom command: ${e.message}");
      rethrow;
    }
  }

  Usage Example:
  final text = "123456";
  final bytes = utf8.encode(text); 

  if (bytes.isEmpty) {
      return;
  }

  BleMethod.sendCustomCommand(Uint8List.fromList(bytes));
```

## 2. Dart Receive Layer Interfaces(ble_event_stream.dart)

### 2.1 Initialize baseStream and EventChannel

```dart
   static const EventChannel _eventChannel = EventChannel('com.jieli.ble_plugin/events');

  // Core broadcast stream
  // Singleton pattern: ensure _baseStream is only initialized once
  static Stream<dynamic>? _baseStream;

  // Public access method for base stream
  static Stream<dynamic> get baseStream {
    _baseStream ??= _eventChannel.receiveBroadcastStream();
    return _baseStream!;
  }
```

### 2.2 Scan State Stream

```dart
  static Stream<String> get scanStateStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_SCAN_DEVICE_LIST)
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      return data[BleEventConstants.KEY_STATE] as String? ?? '';
    });
  }

  Usage Example:
  StreamSubscription<String>? _scanStateSubscription;

  void _subscribeToScanStateStream() {
    _scanStateSubscription = BleEventStream.scanStateStream.listen(
      (state) {
        if (!mounted) return;

        setState(() {
          if (state == BleEventConstants.SCAN_STATE_SCANNING) {
            // Currently scanning, handle UI accordingly
          } else if (state == BleEventConstants.SCAN_STATE_IDLE) {
            // Scan completed, handle UI accordingly
          }
        });
      },
      onError: (error) {
        log("Scan state stream error: $error");
      },
    );
  }
```

### 2.3 Scan Device List Stream

```dart
  static Stream<List<ScanDevice>> get scanDeviceListStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_SCAN_DEVICE_LIST)
        .map((event) {
      final list = event[BleEventConstants.KEY_VALUE][BleEventConstants.KEY_LIST] as List? ?? [];
      return list
          .whereType<Map>()
          .map((deviceMap) => ScanDevice.fromMap(deviceMap))
          .toList();
    });
  }

  Usage Example:
    List<ScanDevice> _devices = [];
    StreamSubscription<List<ScanDevice>>? _scanSubscription;

    List<ScanDevice> convertToScanDeviceList(List<dynamic> list) {
    return list.map((item) {
      if (item is ScanDevice) {
        return item;
      } else if (item is Map) {
        return ScanDevice.fromMap(item);
      } else {
        throw Exception('Incompatible type: ${item.runtimeType}');
      }
    }).toList();
  }

  void _subscribeToScanListStream() {
    _scanSubscription = BleEventStream.scanDeviceListStream.listen((devices) {
      setState(() => _devices = convertToScanDeviceList(devices));
    }) as StreamSubscription<List<ScanDevice>>?;
  }
```

### 2.4 Device Connection Status Stream

```dart

  static Stream<DeviceConnection> get deviceConnectionStream {
    return baseStream
        .where((event) {
      return event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_DEVICE_CONNECTION;
    })
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      return DeviceConnection.fromMap(data);
    });
  }

  Usage Example:
  StreamSubscription<DeviceConnection>? _deviceConnectionSubscription;

  void _subscribeToDeviceConnectionStream() {
    _deviceConnectionSubscription = BleEventStream.deviceConnectionStream
        .listen(
          (connection) async {
        log("Device connection status: ${connection.state}");

        if (connection.state == AppConstants.connectionConnecting) {
          // Handle device connecting UI state
        } else {
          // Handle device not connecting UI state
        }
      },
      onError: (error) {
        log("Device connection stream error: $error");
      },
    ) as StreamSubscription<DeviceConnection>?;
  }
```

### 2.5 OTA Connection Status Stream

```dart

  static Stream<Map<String, dynamic>> get otaConnectionStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_OTA_CONNECTION)
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      return {
        BleEventConstants.KEY_STATE: data[BleEventConstants.KEY_STATE],
        BleEventConstants.KEY_DEVICE_TYPE: data[BleEventConstants.KEY_DEVICE_TYPE],
      };
    });
  }

  Usage Example:
  StreamSubscription<Map<String, dynamic>>? _otaConnectionSubscription;

  void _subscribeToOtaConnectionStream() {
    _otaConnectionSubscription = BleEventStream.otaConnectionStream.listen(
      (otaData) {
        if (mounted) {
          // Process otaData and update UI state
        }
      },
      onError: (error) {
        log("OTA connection stream error: $error");
      },
    );
  }
```


### 2.6 Log File List Stream

```dart

  static Stream<List<Map<String, String>>> get logFilesStream {
    return baseStream
        .where((event) =>
    event is Map &&
        event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_LOG_FILES)
        .map((event) {
      final files = event[BleEventConstants.KEY_FILES] as List? ?? [];
      return files
          .whereType<Map>()
          .map((fileMap) =>
      {
        BleEventConstants.KEY_NAME: fileMap[BleEventConstants
            .KEY_NAME] as String? ?? '',
      }).toList();
    });
  }

  Usage Example:
  List<Map<String, String>> _logFileList = [];
  StreamSubscription? _logFileListSubscription;

  void _subscribeToLogFileListStream() {
    _logFileListSubscription = BleEventStream.logFilesStream.listen(
          (logFileList) {
        setState(() {
          _logFileList = logFileList;
        });
      },
      onError: (error) {
        log("Error listening to logFilesStream: $error", error: error);
      },
    );
  }
```

### 2.7 Log File Detail Stream

```dart

  static Stream<String> get logDetailFilesStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_LOG_DETAIL_FILES)
        .map((event) {
      final files = event[BleEventConstants.KEY_FILES] as List? ?? [];
      return files.first as String? ?? '';
    });
  }

  Usage Example:
  StreamSubscription? logDetailSubscription;
  String logDetailTxt = '';

    logDetailSubscription = BleEventStream.logDetailFilesStream.listen(
      (logDetail) {
        setState(() {
          logDetailTxt = logDetail;
        });
      },
      onError: (error) {
        log("Error listening to logDetailFilesStream: $error");
        logDetailSubscription?.cancel();
      },
    );
```

### 2.8 Download Status Stream

```dart

  static Stream<Map<String, dynamic>> get downloadStatusStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_DOWNLOAD_STATUS)
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      return {
        BleEventConstants.KEY_STATUS: data[BleEventConstants.KEY_STATUS],
        BleEventConstants.KEY_PROGRESS: data[BleEventConstants.KEY_PROGRESS],
        BleEventConstants.KEY_MESSAGE: data[BleEventConstants.KEY_MESSAGE],
      };
    });
  }

  Usage Example:
  StreamSubscription? _downloadStatusSubscription;

  void _startListeningToDownloadStatus() {
    _downloadStatusSubscription = BleEventStream.downloadStatusStream.listen((data) {
      setState(() {
        var state = data[BleEventConstants.KEY_STATUS];
        if (state == BleEventConstants.STATUS_ON_STOP || state == BleEventConstants.STATUS_ON_ERROR) {
          if (mounted) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              AppUtil.readFileList();
            }
          }
        }
        final progressValue = data[BleEventConstants.KEY_PROGRESS];
        if (state == BleEventConstants.STATUS_ON_PROGRESS && progressValue != null) {
          // Display progressValue on UI
        }
      });
    });
  }
```

### 2.9 OTA File List Stream

```dart

  static Stream<List<Map<String, String>>> get otaFileListStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_OTA_FILE_LIST)
        .map((event) {
      final list = event[BleEventConstants.KEY_VALUE][BleEventConstants.KEY_LIST] as List? ?? [];
      return list
          .whereType<Map>()
          .map((fileMap) => {
        BleEventConstants.KEY_NAME: fileMap[BleEventConstants.KEY_NAME] as String? ?? '',
        BleEventConstants.KEY_PATH: fileMap[BleEventConstants.KEY_PATH] as String? ?? '',
      })
          .toList();
    });
  }

  Usage Example:
  StreamSubscription<List<Map<String, String>>>? _otaFileListSubscription;
  List<Map<String, String>> _otaFileList = []; // Used to store file list

  void _startListeningToOtaFileList() {
    _otaFileListSubscription?.cancel();
    _otaFileListSubscription = BleEventStream.otaFileListStream.listen((
      fileList,
    ) {
      if (mounted) {
        setState(() {
          _otaFileList = fileList;
        });
      }
    });
  }
```

### 2.10 Mandatory Upgrade Stream

```dart

  static Stream<bool> get mandatoryUpgradeStream {
    return baseStream
        .where((event) => event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_MANDATORY_UPGRADE)
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      return data[BleEventConstants.KEY_IS_REQUIRED] as bool;
    });
  }

  Usage Example:
  StreamSubscription<bool>? _mandatoryUpgradeSubscription;
  _mandatoryUpgradeSubscription = BleEventStream.mandatoryUpgradeStream
        .listen((isRequired) {
          if (isRequired && mounted) {
            setState(() {
              ToastUtils.show(
                context,
                AppLocalizations.of(context)!.deviceMustMandatoryUpgrade,
              );
            });
          }
        });
```

### 2.11 OTA Status Stream

```dart
  static Stream<Map<String, dynamic>> get otaStateStream {
    return baseStream
        .where((event) =>
    event is Map && event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_OTA_STATE)
        .map((event) {
      final data = event[BleEventConstants.KEY_VALUE];
      final state = data[BleEventConstants.KEY_STATE];
      final result = {
        BleEventConstants.KEY_STATE: state,
        BleEventConstants.KEY_SUCCESS: data[BleEventConstants.KEY_SUCCESS],
        BleEventConstants.KEY_CODE: data[BleEventConstants.KEY_CODE],
        BleEventConstants.KEY_TYPE: data[BleEventConstants.KEY_TYPE],
        BleEventConstants.KEY_MESSAGE: data[BleEventConstants.KEY_MESSAGE],
      };
      if (state == BleEventConstants.KEY_STATE_WORKING) {
        result[BleEventConstants.KEY_PROGRESS] = data[BleEventConstants.KEY_PROGRESS];
      }
      return result;
    });
  }

  Usage Example:
  StreamSubscription? _otaStateSubscription;

  void _startListeningToOtaState() {
    _otaStateSubscription = BleEventStream.otaStateStream.listen((otaData) {
      if (mounted) {
        setState(() {
          updateOtaState(otaData);
        });
      }
    });
  }

  void updateOtaState(Map<String, dynamic> otaData) {
    if (!mounted) return;

    final newOtaState =
        otaData[BleEventConstants.KEY_STATE] as String? ??
            BleEventConstants.KEY_STATE_UNKNOWN;

    setState(() {
      _otaState = newOtaState;

      // Handle different states
      switch (_otaState) {
        case BleEventConstants.KEY_STATE_WORKING:
          // Handle OTA upgrade in progress UI logic
          break;
        case BleEventConstants.KEY_STATE_IDLE:
          // Handle OTA upgrade completed UI logic
          break;
      }
    });
  }
```

### 2.12 Custom Command Data Stream

```dart
 static Stream<Uint8List> get customCommandData {
    return baseStream
        .where((event) =>
    event is Map &&
        event[BleEventConstants.KEY_TYPE] == BleEventConstants.TYPE_CUSTOM_COMMAND_DATA)
        .map((event) {
      try {
        final data = event[BleEventConstants.KEY_VALUE] as Map?;
        if (data == null) return Uint8List(0);

        final customData = data[BleEventConstants.KEY_CUSTOM_DATA];

        if (customData == null) {
          return Uint8List(0);
        }

        if (customData is List) {
          if (customData is List<int>) {
            return Uint8List.fromList(customData);
          }

          final List<int> result = [];
          for (var element in customData) {
            if (element is int) {
              result.add(element);
            } else if (element is num) {
              result.add(element.toInt());
            } else {
              return Uint8List(0);
            }
          }
          return Uint8List.fromList(result);
        }
        return Uint8List(0);
      } catch (e) {
        return Uint8List(0);
      }
    });
  }
  
  Usage Example:
  StreamSubscription<Uint8List>? _dataSubscription;
  Uint8List? _receivedData;

  _dataSubscription = BleEventStream.customCommandData.listen((data) {
      if (mounted && data.isNotEmpty) {
        setState(() {
          _receivedData = data;
        });
      }
  });
```

