import 'package:debug_tools_wifi/model/register.dart';

class MonitorData{

  List<RegisterData> basicData = [];
  List<RegisterData> monitorOne = [];
  List<RegisterData> monitorTwo = [];
  List<RegisterData> monitorThree = [];
  List<RegisterData> monitorFour = [];
  List<RegisterData> monitorFive = [];
  List<RegisterData> monitorSix = [];
  List<RegisterData> tailData = [];
  List<RegisterData> data = [];

  MonitorData({
    this.basicData = const <RegisterData>[],
    this.monitorOne = const <RegisterData>[],
    this.monitorTwo = const <RegisterData>[],
    this.monitorThree = const <RegisterData>[],
    this.monitorFour = const <RegisterData>[],
    this.monitorFive = const <RegisterData>[],
    this.monitorSix = const <RegisterData>[],
    this.tailData = const <RegisterData>[],
    this.data = const <RegisterData>[],
  });

  MonitorData get getData {
    List<RegisterData> list = [];
    list.addAll(_basicData);
    list.addAll(_monitorOne);
    list.addAll(_monitorTwo);
    list.addAll(_monitorThree);
    list.addAll(_monitorFour);
    list.addAll(_monitorFive);
    list.addAll(_monitorSix);
    list.addAll(_tailData);
    return MonitorData(
      basicData: _basicData,
      monitorOne: _monitorOne,
      monitorTwo: _monitorTwo,
      monitorThree: _monitorThree,
      monitorFour: _monitorFour,
      monitorFive: _monitorFive,
      monitorSix: _monitorSix,
      tailData: _tailData,
      data: list
    );
  } 
  
  MonitorData parseData(MonitorData monitorData, List<int> data){
    MonitorData newData = MonitorData();
    newData = monitorData;
    for(int i = 0; i < monitorData.data.length; i++ ){
      List<int> list = [];
      if(i == monitorData.data.length - 1){
        list = data.sublist(i*4);
      }else{
        list = data.sublist(i*4, (i+1)*4);
      }
      newData.data[i].value = list;
    }
    return newData;
  }
  
  String getCharCodes(List<int> list){
    String str = '';
    list.forEach((element) { 
      if(element != 0){
        str += String.fromCharCodes([element]);
      }else{
        str += ' ';
      }
    });
    return str;
  }

}




/// 监测类型
Map<int, String> monitorType = {
  0: '泄流闸',
  1: '泄流管道',
  2: '泄流明渠',
  3: '发电机功率',
  4: '量水堰',
  5: '泄水孔'
};


/// 基础信息
List<RegisterData> _basicData = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x00,
    content: '监测点数量',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x02,
    content: '核定流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x04,
    content: '瞬时总流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
];

/// 监测点一
List<RegisterData> _monitorOne = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x06,
    content: '监测点1监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x08,
    content: '监测点1流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x0A,
    content: '监测点1水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x0C,
    content: '监测点1水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x0E,
    content: '监测点1开度',
    instructions: '监测点1监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x10,
    content: '监测点1功率',
    instructions: '监测点1监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 监测点二
List<RegisterData> _monitorTwo = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x12,
    content: '监测点2监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x14,
    content: '监测点2流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x16,
    content: '监测点2水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x18,
    content: '监测点2水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x1A,
    content: '监测点2开度',
    instructions: '监测点2监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x1C,
    content: '监测点2功率',
    instructions: '监测点2监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 监测点三
List<RegisterData> _monitorThree = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x1E,
    content: '监测点3监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x20,
    content: '监测点3流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x22,
    content: '监测点3水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x24,
    content: '监测点3水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x26,
    content: '监测点3开度',
    instructions: '监测点3监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x28,
    content: '监测点3功率',
    instructions: '监测点3监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 监测点四
List<RegisterData> _monitorFour = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x2A,
    content: '监测点4监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x2C,
    content: '监测点4流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x2E,
    content: '监测点4水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x30,
    content: '监测点4水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x32,
    content: '监测点4开度',
    instructions: '监测点4监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x34,
    content: '监测点4功率',
    instructions: '监测点4监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 监测点五
List<RegisterData> _monitorFive = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x36,
    content: '监测点5监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x38,
    content: '监测点5流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x3A,
    content: '监测点5水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x3C,
    content: '监测点5水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x3E,
    content: '监测点5开度',
    instructions: '监测点5监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x40,
    content: '监测点5功率',
    instructions: '监测点5监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 监测点六
List<RegisterData> _monitorSix = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x42,
    content: '监测点6监测类型',
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x44,
    content: '监测点6流量',
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x46,
    content: '监测点6水位1',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x48,
    content: '监测点6水位2',
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x4A,
    content: '监测点6开度',
    instructions: '监测点6监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
  ),
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x4C,
    content: '监测点6功率',
    instructions: '监测点6监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
  ),
];

/// 尾信息
List<RegisterData> _tailData = [
  RegisterData(
    registerAddressHigh: 0x00,
    registerAddressLow: 0x4E,
    content: '终端软件版本号',
    length: 16,
    isASCII: true
  ),
];

/// 
void typeChange(){

}

