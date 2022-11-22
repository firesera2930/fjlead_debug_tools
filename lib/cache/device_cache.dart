
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';


/// 设备信息
class DeviceCache {

  /// 是否是模拟器
  bool isSimulator = false;
  /// 系统名称
  String systemTitle = '';
  /// 系统类型
  SystemType systemType = SystemType.none;
  /// 系统版本
  String systemVersion = '';
  /// 设备型号
  String deviceEquipmentModel = '';

  DeviceCache._();

  static DeviceCache _instance = DeviceCache._();

  static DeviceCache getInstance() => _instance;


  /// 检查设备
  static Future<void> inspectDevice() async {

    var log = '';

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    bool _isWeb = kIsWeb == true;
  

    if(_isWeb){
      
    }else if(Platform.isIOS) {

      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      log += '设备类型: ' + (iosInfo.isPhysicalDevice ? '真机' :'模拟器') + '\n';
      log += '操作系统: iOS\n';
      log += '系统版本: ' + (iosInfo.systemVersion ?? '') + '\n';
      log += '设备机型: ' + (iosInfo.model ?? '') + '\n';

      DeviceCache.getInstance().systemTitle = 'iOS';
      DeviceCache.getInstance().systemType = SystemType.mobile;
      DeviceCache.getInstance().systemVersion = iosInfo.systemVersion ?? '';
      DeviceCache.getInstance().deviceEquipmentModel = iosInfo.model ?? '';
      DeviceCache.getInstance().isSimulator = ! iosInfo.isPhysicalDevice;
      if(DeviceCache.getInstance().isSimulator) DeviceCache.getInstance().deviceEquipmentModel = '模拟器';
      debugPrint(log);
      
    }else if (Platform.isAndroid){

      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log += '设备类型: ' + (androidInfo.isPhysicalDevice ? '真机' :'模拟器') + '\n';
      log += '操作系统: Android\n';
      log += '系统版本: ' + androidInfo.version.release + '\n';
      log += '设备机型: ' + androidInfo.model + '\n';

      DeviceCache.getInstance().systemTitle = 'Android';
      DeviceCache.getInstance().systemType = SystemType.mobile;
      DeviceCache.getInstance().systemVersion = androidInfo.version.release;
      DeviceCache.getInstance().deviceEquipmentModel = androidInfo.model;
      DeviceCache.getInstance().isSimulator = !androidInfo.isPhysicalDevice;
      if(DeviceCache.getInstance().isSimulator) DeviceCache.getInstance().deviceEquipmentModel = '模拟器';
      debugPrint(log);
    }else if(Platform.isMacOS){
      MacOsDeviceInfo macOsInfo = await deviceInfo.macOsInfo;
      log += '设备类型: 真机\n';
      log += '操作系统: macOS\n';
      log += '系统版本: ' + macOsInfo.osRelease + '\n';
      log += '设备机型: ' + macOsInfo.model + '\n';

      DeviceCache.getInstance().systemTitle = 'macOS';
      DeviceCache.getInstance().systemType = SystemType.desktop;
      DeviceCache.getInstance().systemVersion = macOsInfo.osRelease;
      DeviceCache.getInstance().deviceEquipmentModel = macOsInfo.model;
      DeviceCache.getInstance().isSimulator = false;
      debugPrint(log);
    }else if(Platform.isWindows){
      WindowsDeviceInfo windowsInfo = await deviceInfo.windowsInfo;
      log += '设备类型: 真机\n';
      log += '操作系统: Windows\n';
      log += '系统版本: \n';
      log += '设备机型: ' + windowsInfo.computerName + '\n';

      DeviceCache.getInstance().systemTitle = 'Windows';
      DeviceCache.getInstance().systemType = SystemType.desktop;
      DeviceCache.getInstance().systemVersion = '';
      DeviceCache.getInstance().deviceEquipmentModel = windowsInfo.computerName;
      DeviceCache.getInstance().isSimulator = false;
      debugPrint(log);
    }else if(Platform.isLinux){
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      log += '设备类型: 真机\n';
      log += '操作系统: Linux\n';
      log += '系统版本: \n';
      log += '设备机型: ' + (linuxInfo.versionCodename ?? '') + '\n';

      DeviceCache.getInstance().systemTitle = 'Linux';
      DeviceCache.getInstance().systemType = SystemType.desktop;
      DeviceCache.getInstance().systemVersion = '';
      DeviceCache.getInstance().deviceEquipmentModel = linuxInfo.versionCodename ?? '';
      DeviceCache.getInstance().isSimulator = false;
      debugPrint(log);
    }
  }

}

/// 系统类型
enum SystemType{
  /// 移动端
  mobile,
  /// 桌面端
  desktop,
  /// 未知
  none
}