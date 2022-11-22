
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:flutter/material.dart';


class MonitorPointData {

  List<RegisterData> baseData = [];
  List<RegisterData> data = [];

  MonitorPointData({
    this.baseData = const <RegisterData>[],
    this.data = const <RegisterData>[],
  });

  MonitorPointData get getData {
    List<RegisterData> list = [];
    list.addAll(pointData);
    return MonitorPointData(
        baseData: pointData,
        data: list
    );
  }

  MonitorPointData parseData(MonitorPointData baseData, List<int> data) {
    MonitorPointData newData = MonitorPointData();
    newData = baseData;
    for(int i = 0; i < baseData.data.length; i++ ){
      RegisterData registerData = baseData.data[i];
      List<int> list = [];
      list = data.sublist(i*4, (i+1)*4);
      newData.data[i].value = list;
    }
    return newData;
  }
}

/// 基础信息
List<RegisterData> pointData = [
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x0E,
    addressHigh: '01',
    addressLow: '0E',
    content: '监测点数量',
    instructions: '范围：1～6',
    multiple: 10000,
    minValue: 1,
    maxValue: 6,
    defaultString: '输入范围：1～6',
  ),
  RegisterData(
    registerAddressHigh: 0x01,
    registerAddressLow: 0x10,
    addressHigh: '01',
    addressLow: '10',
    content: '监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔。用下拉列表框选择。',
  ),
];