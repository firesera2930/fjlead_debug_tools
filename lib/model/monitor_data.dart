import 'package:debug_tools_wifi/model/register.dart';

class MonitorData{

  List<RegisterData> data = [];

  MonitorData({
    this.data = const <RegisterData>[]
  });

  MonitorData get getData {
    List<RegisterData> list = [];
    list.addAll(basicData);
    list.addAll(monitorOne);
    list.addAll(monitorTwo);
    list.addAll(monitorThree);
    list.addAll(monitorFour);
    list.addAll(monitorFive);
    list.addAll(monitorSix);
    list.addAll(tailData);
    return MonitorData(data:list);
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


/// 基础信息
List<RegisterData> basicData = [
  RegisterData(
    registerAddress: 0x0000,
    content: '监测点数量',
    length: 4,
    instructions: '',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0002,
    content: '核定流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0004,
    content: '瞬时总流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
];

/// 监测点一
List<RegisterData> monitorOne = [
  RegisterData(
    registerAddress: 0x0006,
    content: '监测点1监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0008,
    content: '监测点1流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x000A,
    content: '监测点1水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x000C,
    content: '监测点1水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x000E,
    content: '监测点1开度',
    length: 4,
    instructions: '监测点1监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0010,
    content: '监测点1功率',
    length: 4,
    instructions: '监测点1监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 监测点二
List<RegisterData> monitorTwo = [
  RegisterData(
    registerAddress: 0x0012,
    content: '监测点2监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0014,
    content: '监测点2流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0016,
    content: '监测点2水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0018,
    content: '监测点2水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x001A,
    content: '监测点2开度',
    length: 4,
    instructions: '监测点2监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x001C,
    content: '监测点2功率',
    length: 4,
    instructions: '监测点2监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 监测点三
List<RegisterData> monitorThree = [
  RegisterData(
    registerAddress: 0x001E,
    content: '监测点3监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0020,
    content: '监测点3流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0022,
    content: '监测点3水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0024,
    content: '监测点3水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0026,
    content: '监测点3开度',
    length: 4,
    instructions: '监测点3监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0028,
    content: '监测点3功率',
    length: 4,
    instructions: '监测点3监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 监测点四
List<RegisterData> monitorFour = [
  RegisterData(
    registerAddress: 0x002A,
    content: '监测点4监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x002C,
    content: '监测点4流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x002E,
    content: '监测点4水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0030,
    content: '监测点4水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: [] 
  ),
  RegisterData(
    registerAddress: 0x0032,
    content: '监测点4开度',
    length: 4,
    instructions: '监测点4监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0034,
    content: '监测点4功率',
    length: 4,
    instructions: '监测点4监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 监测点五
List<RegisterData> monitorFive = [
  RegisterData(
    registerAddress: 0x0036,
    content: '监测点5监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0038,
    content: '监测点5流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x003A,
    content: '监测点5水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x003C,
    content: '监测点5水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x003E,
    content: '监测点5开度',
    length: 4,
    instructions: '监测点5监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0040,
    content: '监测点5功率',
    length: 4,
    instructions: '监测点5监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 监测点六
List<RegisterData> monitorSix = [
  RegisterData(
    registerAddress: 0x0042,
    content: '监测点6监测类型',
    length: 4,
    instructions: '0～5对应6种监测类型：泄流闸、泄流管道、泄流明渠、发电机功率、量水堰、泄水孔，显示类型名称，不是显示数字。',
    multiple: 1,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0044,
    content: '监测点6流量',
    length: 4,
    instructions: '4位小数(数据放大10000倍)，单位： m3/s',
    multiple: 10000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0046,
    content: '监测点6水位1',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x0048,
    content: '监测点6水位2',
    length: 4,
    instructions: '2位小数(数据放大100倍)，单位： m',
    multiple: 100,
    value: []
  ),
  RegisterData(
    registerAddress: 0x004A,
    content: '监测点6开度',
    length: 4,
    instructions: '监测点6监测类型为泄流闸时,APP界面才显示开度',
    multiple: 1000,
    value: []
  ),
  RegisterData(
    registerAddress: 0x004C,
    content: '监测点6功率',
    length: 4,
    instructions: '监测点6监测类型为发电机功率时,APP界面才显示功率',
    multiple: 10,
    value: []
  ),
];

/// 尾信息
List<RegisterData> tailData = [
  RegisterData(
    registerAddress: 0x004E,
    content: '终端软件版本号',
    length: 16,
    instructions: '',
    multiple: 1,
    value: []
  ),
];


