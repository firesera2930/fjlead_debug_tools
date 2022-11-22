
import 'package:debug_tools_wifi/model/register.dart';

class CameraData {
  List getCameraData(List<int> data) {
    List allData = [];
    List<RegisterData> registerList= [];
    registerList.addAll(cameraListData);
    int l = 0;
    int al = 0;
    for(int i = 0; i < registerList.length; i++) {
      List list = [];
      RegisterData registerData = registerList[i];
      if (i > 0) {
        RegisterData registerDataOld = registerList[i-1];
        l = l + registerDataOld.length;
      }
      al = l + registerData.length;
      List hexList = data.sublist(l, al);
      list.add(registerData);
      list.add(hexList);
      allData.add(list);
    }
    return allData;
  }
}

/// 摄像头
List<RegisterData> cameraListData = [
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x00,
    addressHigh: '08',
    addressLow: '00',
    content: '摄像头数量',
    instructions: '0～4',
    length: 2,
    minValue: 0,
    maxValue: 4,
    defaultString: '0～4',
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x01,
    addressHigh: '08',
    addressLow: '01',
    content: '图像抓取间隔时间',
    instructions: '0～600分钟',
    length: 2,
    minValue: 0,
    maxValue: 600,
    defaultString: '0～600分钟',
    unit: 'min',
  ),
  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x02,
    addressHigh: '08',
    addressLow: '02',
    content: '短视频抓取间隔时间',
    instructions: '0～600分钟',
    length: 2,
    minValue: 0,
    maxValue: 600,
    defaultString: '0～600分钟',
    unit: 'min',
  ),

  RegisterData(
      registerAddressHigh: 0x08,
      registerAddressLow: 0x03,
      addressHigh: '08',
      addressLow: '03',
      content: '短视频时长',
      instructions: '1～3600   单位：秒',
      length: 2,
      unit: 's',
    minValue: 1,
    maxValue: 3600,
    defaultString: '1～3600',
  ),

  RegisterData(
    registerAddressHigh: 0x08,
    registerAddressLow: 0x04,
    addressHigh: '08',
    addressLow: '04',
    content: '水印刷新周期',
    instructions: '5～3600，单位：s',
    unit: 's',
    minValue: 5,
    maxValue: 3600,
    defaultString: '5～3600',
  ),
];