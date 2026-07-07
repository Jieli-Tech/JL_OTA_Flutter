[tag download]:https://github.com/Jieli-Tech/JL_OTA_Flutter/tags
[tag_badgen]:https://img.shields.io/github/v/tag/Jieli-Tech/JL_OTA_Flutter?style=plastic&logo=flutter&labelColor=ffffff&color=informational&label=Tag&logoColor=blue
# JL_OTA_Flutte [![tag][tag_badgen]][tag download]

<div align="center">

**JL OTA SDK(Flutter) - An Integrated SDK for Firmware Upgrade of JieLi Bluetooth Products**

[Chinese](./README.md) · [English](./README_EN.md) · [Documentation Center](./doc/) · [SDK Changelog](#8-version-history) · [Report Issues](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues)

</div>

---

## Table of Contents

- [1. Overview](#1-overview)
- [2. Environment Requirements](#2-environment-requirements)
- [3. Quick Start](#3-quick-start)
- [4. Project Structure](#4-project-structure)
- [5. Configuration Guide](#5-configuration-guide)
- [6. Debugging Tips](#6-debugging-tips)
- [7. Community & Support](#7-community--support)
- [8. Version History](#8-version-history)
- [9. License](#9-license)

---

## 1. Overview

`JL_OTA_Flutter` is a firmware upgrade development platform provided by **Zhuhai Jieli Technology Co., Ltd.** for JieLi Bluetooth products. This SDK is specifically designed to implement <strong style="color:red">RCSP OTA</strong> upgrade functionality for our company's Bluetooth products, supporting multiple transport methods such as BLE and SPP, and providing a complete firmware upgrade workflow.

**杰理OTA SDK(Flutter)** provides a rich set of upgrade features:

| Feature | Description |
| -------------- | -------------------------------------------------------- |
| **BLE Upgrade** | Firmware upgrade via BLE channel, supporting Gatt Over BR/EDR |
| **SPP Upgrade** | Firmware upgrade via classic Bluetooth SPP channel |
| **Auto Reconnect** | Automatic BLE reconnection for single-backup OTA, improving user experience |
| **Reuse Space Upgrade** | Supports special upgrade process for reused space |

---

## 2. Environment Requirements

| Category | Requirement | Description |
|------|------------|------|
| **Operating System** | Android 6.0+、IOS 12.0+  | Supports BLE functionality |
| **Hardware** | JieLi SDK with **RCSP OTA** support | AC707N, AC703N, AC701N, AC697N, AC696N, AC695N, etc. |
| **Development Platform** | Android Studio(Supports Flutter) | Latest version recommended |
| **Language Support** | Java/Kotlin | Full API support provided |

---

## 3. Quick Start

### 3.1 Clone the Repository

```bash
git clone https://github.com/Jieli-Tech/JL_OTA_Flutter.git
cd JL_OTA_Flutter
```

## 3.2 Import the Project into Android Studio

1. Open Android Studio
2. Select **"Open an existing project"**
3. Navigate to the extracted `code/` directory
4. Open the project file inside `JL_OTA`



### 3.3 Plugin Reference

```pubspec.yaml
plugin:
  platforms:
    android:
      package: com.jieli.otasdk
      pluginClass: JlOtaPlugin
    ios:
      pluginClass: JlOtaPlugin
```



### 3.4 Run the Sample App

Run the project on an Android or iOS device to access and use all the App's features.

---



## 4. Project Structure

```
JL_OTA_Flutter/
├── code/                                    # Reference source code folder
│   └── JL_OTA                               # Jieli OTA (Flutter) project source code
├── doc/                                     # Documentation folder
│   ├── Jieli OTA Upgrade (Flutter) - Send/Receive Interface Introduction_en.md   # English Documentation 
│   ├── Jieli OTA Upgrade (Flutter) - Send/Receive Interface Introduction.md      # Chinese Documentation
│   └── ReadMe.txt                           # Readme file
└── libs/                                    # Core API interface folder
    ├── Receive Interface                    # Receive interfaces for Jieli OTA (Flutter)
    └── Send Interface                       # Send interfaces for Jieli OTA (Flutter)
```

---



## 5. Configuration Guide

### 5.1 JL_OTA_Flutter (`code/JL_OTA/`)

| Item | Description |
|------|------|
| **Use Cases** | OTA upgrades via BLE, SPP, and GATT Over BR/EDR |
| **Key Features** | OTA upgrades |
| **Reference Docs** | [SDK Integration Guide](./doc/) |

---

## 6. Debugging Tips

- **Log Output**: The SDK offers comprehensive logging capabilities. You can check the OTA connection status and data exchange through the log output.

- **Viewing Logs**:
  - **Android**: Use Android Studio's Logcat tool to view real-time logs.
  - **iOS**: Use Xcode's Console to view real-time logs.

- **Troubleshooting**:
  - **Android SDK**: See [Android SDK Debugging Guide](https://doc.zh-jieli.com/Apps/Android/ota/zh-cn/master/other/debug.html)
  - **iOS SDK**: See [iOS SDK Debugging Guide](https://doc.zh-jieli.com/Apps/iOS/ota/zh-cn/master/Other/debug.html)
---



## 7. Community and Support

### 7.1 Technical Communication

| Platform | Contact | Status |
|----------|---------|--------|
| **Official Website** | [Jieli Technology](https://www.zh-jieli.com/) | ✅ Active |
| **GitHub Issues** | [Feedback](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues) | ✅ Active |



### 7.2 Resources

| Resource | Link |
|----------|------|
| 📄 **Datasheet** | [Development Documentation](./doc/) |
| 📚 **Version History** | [Version History](#8-version-history) |
| 🐛 **Feedback** | [GitHub Issues](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues) |

---



## 8. Version History

| Version | Date | Change Log |
|---------|------|------------|
| V1.1.0 | 2026/07/03 | **Android**:<br>1. Added support for special upgrade process with reusable space.<br>2. Added BLE auto-reconnection feature for single-backup OTA.<br>3. Added support for GATT Over BR/EDR connection.<br>4. Added custom command support.<br><br>**iOS**:<br>1. Fixed OTA reconnection timeout issue.<br>2. Added support for GATT Over BR/EDR connection.<br>3. Added custom command support. |
| V1.0.0 | 2025/11/19 | Initial release |



## 9. License

This project is licensed under the [Apache License 2.0](./LICENSE).

```
Copyright 2024 Zhuhai Jieli Technology Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

<div align="center">
**© 2024 Zhuhai Jieli Technology Co., Ltd. | Licensed under Apache License 2.0**
</div>

