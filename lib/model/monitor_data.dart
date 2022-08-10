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
enum MonitorType{
  dischargeGate,      // 0 泄流闸
  dischargePipe,      // 1 泄流管道
  dischargeChannel,   // 2 泄流明渠
  generatorPower,     // 3 发电机功率
  measuringWeir,      // 4 量水堰
  drainHole           // 5 泄水孔
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
List<RegisterData> _monitorOne = [
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
List<RegisterData> _monitorTwo = [
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
List<RegisterData> _monitorThree = [
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
List<RegisterData> _monitorFour = [
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
List<RegisterData> _monitorFive = [
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
List<RegisterData> _monitorSix = [
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
List<RegisterData> _tailData = [
  RegisterData(
    registerAddress: 0x004E,
    content: '终端软件版本号',
    length: 16,
    instructions: '',
    multiple: 1,
    value: []
  ),
];


