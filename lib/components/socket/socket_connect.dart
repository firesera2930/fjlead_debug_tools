import 'dart:convert';
import 'dart:io';

import 'package:debug_tools_wifi/app/app_config.dart';
import 'package:flutter/material.dart';

import 'package:hex/hex.dart';


/// Socket连接
/// 
class SocketConnect {

  RawSocket? _socket;
  /// 是否链接
  bool isConnect = false;
  List<int> rd=[];
  String readTime = '';
  List<Map> debugLogs = [];
  List<String> logList = [];

  bool isDebugPage = false;

  SocketConnect();

  /// 连接
  Future<void> onTapConnect({String? host, int? port}) async {
    String currentIP = host ?? AppConfig.getInstance().baseIP;
    int currentPort = port ?? AppConfig.getInstance().basePort;
    await _socket?.close();
    try {
      _socket = await RawSocket.connect(currentIP, currentPort, timeout: Duration(seconds:1));
      isConnect = true;
      debugPrint('✅ Socket连接成功!');
    } catch (e) {
      isConnect = false;
      if(e is SocketException){
        SocketException os = e;
        debugPrint(os.message);
      }
      debugPrint(e.toString());
    }
  }

  /// 关闭
  void dispose(){
    _socket?.close();
  }

  /// 数据监听
  void lisenData({required Function(List<int>) onRead})async{
    _socket?.listen((event)async { 
         //订阅的消息
      if(event == RawSocketEvent.read) {
        if((_socket?.available() ?? 0) >0) {
          rd = _socket?.read() ?? [];
          onRead(rd);
          debugPrint('监听read' + rd.toString());
          readTime = DateTime.now().toString().substring(0,19);
          isConnect = true;

          //调试日志接收数据存本地
          if (isDebugPage) {
            Map logMap = {'direction':'接收',
                            'time':readTime,
                            'byte':intListToDisplayString(rd),};
            addDebugLogs(logMap);
            String logStr = jsonEncode(logMap);
            logList.add(logStr);
            //saveStringList(ApiShare().dateLogName, logList);
          }
        }
         
      }else if(event == RawSocketEvent.write) {
        //连接的时候会进入
        debugPrint('write');
        isConnect = true;
      }else if(event == RawSocketEvent.closed) {
        //手动输入断开
        debugPrint('closed');
        _socket?.close();
        isConnect = false;
      }else if(event == RawSocketEvent.readClosed) {
        debugPrint('readClosed');
        isConnect = true;
      }
    },
    onDone: (){
      print('onDone');
      isConnect = false;
    },
    onError: (error){
      print(error);
      isConnect = false;
    });
  }

  

  /// 调试日志数据
  void addDebugLogs(Map log){
    debugLogs.add(log);
  }

  /// 发送
  Future<void> onTapSendBytes(List<int> buffer) async {
    int? i = _socket?.write(buffer);
    debugPrint('写时间:'+ DateTime.now().toString());
    // writeTime =  DateTime.now().toString().substring(0,19);
  }

  void onTapReceiveBytes() async {
    readTime = '';
    List<int>? uint8List = _socket?.read();
    debugPrint('读时间:'+ DateTime.now().toString());
    String str = HEX.encode(uint8List ?? []);
    debugPrint(str);
    // writeTime =  DateTime.now().toString().substring(0,19);
  }

}

String intListToDisplayString(List<int> bytes) {
  var result = '';
  for(int i = 0 ; i < bytes.length ; i++) {
    var unit = HEX.encode(bytes.sublist(i,i+1));
    unit += ' ';
    result += unit;
  }
  return result.trim().toUpperCase();
}




