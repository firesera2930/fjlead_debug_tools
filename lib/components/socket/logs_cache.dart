import 'dart:convert';

import 'package:debug_tools_wifi/model/logs_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 报文记录缓存
class LogsCache{

  /// 报文列表
  Set<LogsData> logsList = {};
  /// 发送报文列表 
  Set<LogsData> sendLogsList = {};
  /// 接收报文列表
  Set<LogsData> receivedLogsList = {};

  /// 序号列表
  Set<String> codeList = {};


  LogsCache._();

  static LogsCache _instance = LogsCache._();

  static LogsCache getInstance() => _instance;

  /// 新增报文记录
  void addLogs(LogsData logsData) async {

    _read(logsData);
    
    String jsonStr = json.encode(logsData.toMap());
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    await prefs.setString(logsData.code.toString(),jsonStr);
    codeList.add(logsData.code.toString());
    await prefs.setStringList('codeList', codeList.toList());
  }

  /// 初始化
  Future<void> initLogs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> _code = prefs.getStringList('codeList') ?? [];

    _code.forEach((code) { 
      String jsonStr = prefs.getString(code) ?? '';
      LogsData logsData = LogsData.fromJson(json.decode(jsonStr));
      _read(logsData);
    });
  }

  /// 读取数据缓存
  void _read(LogsData logsData){
    if(logsData.logType == LogType.send){
      sendLogsList.add(logsData);
      logsList.add(logsData);
    }else if(logsData.logType == LogType.received){
      receivedLogsList.add(logsData);
      logsList.add(logsData);
    }
    codeList.add(logsData.code.toString());
  }

  /// 清除记录
  Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    logsList = {};
    sendLogsList = {};
    receivedLogsList = {};
    codeList = {};

    await prefs.setStringList('codeList', codeList.toList());
  }
}