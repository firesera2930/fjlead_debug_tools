
/// 记录数据
class LogsData{

  int code = 0;
  // 类型
  LogType logType = LogType.none;
  // 时间
  DateTime? time;
  // 报文内容
  String byteStr = '';

  LogsData({
    required this.code,
    required this.logType,
    required this.time,
    required this.byteStr
  });

  LogsData.fromJson(Map<String, dynamic> json){
    code = int.parse(json['code'] ?? '0');
    if(json['logType'] == 'send'){
      logType = LogType.send;
    }else if(json['logType'] == 'received'){
      logType = LogType.received;
    }else{
      logType = LogType.none;
    }
    time = json['time'] != null ? DateTime.parse(json['time']!) : null;
    byteStr = json['byteStr'] ?? '';
  }

  Map<String, String> toMap(){

    Map<String, String> map = {};
    map['code'] = code.toString();
    if(logType == LogType.send){
      map['logType'] = 'send';
    }else if(logType == LogType.received){
      map['logType'] = 'received';
    }else{
      map['logType'] = 'none';
    }
    map['time'] = time.toString();
    map['byteStr'] = byteStr;

    return map;
  }
}


/// 记录数据类型
enum LogType{
  send,
  received,
  none
}