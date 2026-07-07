[tag download]:https://github.com/Jieli-Tech/JL_OTA_Flutter/tags
[tag_badgen]:https://img.shields.io/github/v/tag/Jieli-Tech/JL_OTA_Flutter?style=plastic&logo=flutter&labelColor=ffffff&color=informational&label=Tag&logoColor=blue
# JL_OTA_Flutter [![tag][tag_badgen]][tag download] 

<div align="center">

**杰理OTA SDK(Flutter) - 专为杰理蓝牙类产品提供固件升级功能的集成SDK**

[中文](./README.md) · [English](./README_EN.md) · [文档中心](./doc/) · [SDK 版本历史](#八版本历史) · [报告问题](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues)

</div>

---

## 📋 目录

- [一、概述](#一概述)
- [二、运行环境](#二运行环境)
- [三、快速开始](#三快速开始)
- [四、工程结构](#四工程结构)
- [五、配置说明](#五配置说明)
- [六、调试技巧](#六调试技巧)
- [七、社区与支持](#七社区与支持)
- [八、版本历史](#八版本历史)
- [九、许可证](#九许可证)

---



## 一、概述

`JL_OTA_Flutter` 是**珠海市杰理科技股份有限公司**为杰理蓝牙类产品提供的固件升级开发平台。本 SDK 专门实现本公司蓝牙类产品的 <strong style="color:red">RCSP OTA</strong> 升级功能，支持 BLE、SPP 等多种传输方式，提供完整的固件升级流程。

**杰理OTA SDK(Flutter)**提供了丰富的升级功能：

| 功能           | 说明                                                     |
| -------------- | -------------------------------------------------------- |
| **BLE升级** | 通过BLE通道进行固件升级，支持``Gatt Over BR/EDR``方式 |
| **SPP升级**   | 通过经典蓝牙SPP通道进行固件升级                  |
| **自动回连**   | 单备份OTA自动回连BLE功能，提升用户体验                           |
| **复用空间升级** | 支持复用空间特殊升级流程                             |

---



## 二、运行环境

| 类别 | 要求 | 说明 |
|------|------------|-----------|
| **操作系统** | Android 6.0+、IOS 12.0+  | 支持BLE功能 |
| **硬件要求** | 支持**RCSP OTA**功能的杰理SDK | AC707N、AC703N、AC701N、AC697N、AC696N、AC695N等 |
| **开发平台** | Android Studio(支持Flutter) | 建议使用最新版本 |
| **语言支持** | Dart/Kotlin/Swift | 提供完整的API支持 |


---



## 三、快速开始

### 3.1 克隆仓库

```bash
git clone https://github.com/Jieli-Tech/JL_OTA_Flutter.git
cd JL_OTA_Flutter
```

### 3.2 导入项目到Android Studio

1. 打开 Android Studio
2. 选择 "Open an existing project"
3. 导航到解压后的 `code/` 目录
4. 打开 `JL_OTA`  中的项目文件



### 3.3 添加依赖库

```pubspec.yaml
plugin:
  platforms:
    android:
      package: com.jieli.otasdk
      pluginClass: JlOtaPlugin
    ios:
      pluginClass: JlOtaPlugin
```



### 3.4 运行示例应用

运行项目到Android或者IOS设备，即可使用App的各项功能。

---



## 四、工程结构

```
JL_OTA_Flutter/
├── code/                                    # 参考源码工程文件夹
│   └── JL_OTA                               # 杰理OTA(Flutter)项目源码
├── doc/                                     # 文档文件夹
│   ├── Jieli OTA Upgrade (Flutter) - Send/Receive Interface Introduction_en.md   # 英文文档
│   ├── Jieli OTA Upgrade (Flutter) - Send/Receive Interface Introduction.md      # 中文文档
│   └── ReadMe.txt                           # 说明文件
└── libs/                                    # 核心收发接口文件夹
    ├── ble_event_stream.dart                # 杰理OTA升级(Flutter)的接收接口
    └── ble_method.dart                      # 杰理OTA升级(Flutter)的发送接口
```

---



## 五、配置说明

### 5.1 JL_OTA_Flutter (`code/JL_OTA/`)

| 项目 | 说明 |
|------|------|
| **适用场景** | BLE、SPP、Gatt Over BR/EDR的升级 |
| **关键特性** | OTA 升级 |
| **参考文档** | [SDK 接入文档](./doc/) |

---

## 六、调试技巧

- **日志输出**：SDK提供详细的日志输出，可通过日志查看OTA连接状态和数据交互

- **日志查看方式**：
  - **Android**：使用 Android Studio 的 Logcat 工具查看实时日志。
  - **iOS**：使用 Xcode 的 Console（控制台）查看实时日志。

- **问题排查**：
  - **Android SDK**：详见 [Android SDK 调试说明](https://doc.zh-jieli.com/Apps/Android/ota/zh-cn/master/other/debug.html)
  - **iOS SDK**：详见 [iOS SDK 调试说明](https://doc.zh-jieli.com/Apps/iOS/ota/zh-cn/master/Other/debug.html)
---



## 七、社区与支持

### 7.1 技术交流

| 平台 | 联系方式 | 状态 |
|------|----------|------|
| **官方网站** | [杰理科技](https://www.zh-jieli.com/) | ✅ 活跃 |
| **GitHub Issues** | [问题反馈](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues) | ✅ 活跃 |



### 7.2 资源链接

| 资源 | 链接 |
|------|------|
| 📄 **数据手册** | [开发说明文档](./doc/) |
| 📚 **版本历史** | [版本历史](#八版本历史) |
| 🐛 **问题反馈** | [GitHub Issues](https://github.com/Jieli-Tech/JL_OTA_Flutter/issues) |

---



## 八、版本历史

| 版本 | 日期 | 修改记录 |
|------|------|----------|
| V1.1.0 | 2026/07/03 | Android:<br>1.增加复用空间特殊升级流程支持.<br>2.增加单备份OTA自动回连BLE功能.<br>3.增加Gatt Over BR/EDR连接方式支持.<br>4.增加自定义命令.<br>IOS:<br>1.修复OTA回连超时问题.<br>2.增加Gatt Over BR/EDR连接方式支持.<br>3.增加自定义命令.| 
| V1.0.0 | 2025/11/19 | 初始版本发布|
---



## 九、许可证

本项目采用 [Apache License 2.0](./LICENSE) 开源协议。

```
Copyright 2024 珠海市杰理科技股份有限公司

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

**© 2024 珠海市杰理科技股份有限公司 | Licensed under Apache License 2.0**

</div>

