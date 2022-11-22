import 'dart:io';

import 'package:debug_tools_wifi/app/app_config.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/cache/logs_cache.dart';
import 'package:debug_tools_wifi/model/logs_data.dart';
import 'package:debug_tools_wifi/model/message_parse.dart';
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


  SocketConnect();

  /// 连接
  Future<void> onTapConnect({String? host, int? port, Function()? onFinish, Function()? onError}) async {
    String currentIP = host ?? AppConfig.getInstance().baseIP;
    int currentPort = port ?? AppConfig.getInstance().basePort;
    
    await _socket?.close();
    try {
      _socket = await RawSocket.connect(currentIP, currentPort, timeout: Duration(seconds:1));
      isConnect = true;
      debugPrint('✅ Socket连接成功!');
      onFinish!();
    } catch (e) {
      isConnect = false;
      if(e is SocketException){
        SocketException os = e;
        debugPrint(os.message);
      }
      debugPrint(e.toString());
      onError!();
    }
  }

  /// 关闭
  void dispose(){
    _socket?.close();
  }

  /// 数据监听
  void lisenData({required Function(List<int>) onRead, required Function(bool) connectState})async{
    try {
      _socket?.listen((event)async { 
         //订阅的消息
        if(event == RawSocketEvent.read) {
          if((_socket?.available() ?? 0) >0) {
            rd = _socket?.read() ?? [];
            onRead(rd);
            debugPrint('监听read' + rd.toString());
            readTime = DateTime.now().toString().substring(0,19);
            isConnect = true;
            connectState(true);
            List<int> list = rd.sublist(0,2);
            int code = ByteTool.byte16(list.first,list.last);
            debugPrint('code: $code');
            LogsData logsData = LogsData(
              code: 0,
              logType: LogType.received,
              time: DateTime.now(),
              byteStr: intListToDisplayString(rd)
            );

            LogsCache.getInstance().addLogs(logsData);

            debugPrint('读取: ${logsData.toMap().toString()}');
            debugPrint('报文数量: ${LogsCache.getInstance().logsList.length}');
            debugPrint('发送数量: ${LogsCache.getInstance().sendLogsList.length}');
            debugPrint('收到数量: ${LogsCache.getInstance().receivedLogsList.length}');
          }
          
        }else if(event == RawSocketEvent.write) {
          //连接的时候会进入
          debugPrint('write');
          isConnect = true;
          connectState(true);
        }else if(event == RawSocketEvent.closed) {
          //手动输入断开
          debugPrint('closed');
          _socket?.close();
          isConnect = false;
          connectState(false);
        }else if(event == RawSocketEvent.readClosed) {
          debugPrint('readClosed');
          isConnect = true;
          connectState(true);
        }
      },
      onDone: (){
        print('onDone');
        isConnect = false;
        connectState(false);
      },
      onError: (error){
        print(error);
        isConnect = false;
        connectState(false);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    
  }


  /// 发送
  Future<void> onTapSendBytes(List<int> buffer) async {
    List<String> list = LogsCache.getInstance().codeList.toList();
    int i = list.length > 0 ? int.parse(list.last) : 0;

    // buffer[0] = ByteTool.high(i);
    // buffer[1] = ByteTool.low(i);

    LogsData logsData = LogsData(
      code: i+1,
      logType: LogType.send,
      time: DateTime.now(),
      byteStr: intListToDisplayString(buffer)
    );
    LogsCache.getInstance().addLogs(logsData);
    _socket?.write(buffer);
    debugPrint('写入:'+ logsData.toMap().toString());
    // writeTime =  DateTime.now().toString().substring(0,19);
  }

  void onTapReceiveBytes() async {
    readTime = '';
    List<int>? uint8List = _socket?.read();
    debugPrint('读时间:'+ DateTime.now().toString());
    String str = HEX.encode(uint8List ?? []);
    debugPrint('onTapReceiveBytes'+ str);
    // writeTime =  DateTime.now().toString().substring(0,19);
  }

}

String intListToDisplayString(List<int> bytes) {
  var result = '';
  for(int i = 0 ; i < bytes.length ; i++) {
    var unit = HEX.encode(bytes.sublist(i,i+1));
    String hex = bytes[i].toStringAsFixed(16);
    unit += ' ';
    result += unit;
  }
  return result.trim().toUpperCase();

  // var result = '';
  // for(int i = 0 ; i < bytes.length ; i++) {
  //
  //   String hex = bytes[i].toRadixString(16);
  //   hex.length == 1 ? hex = '0$hex' : hex = hex;
  //   result.length == 0 ? result = hex : result = result +' ' + hex;
  // }
  // return result.trim().toUpperCase();
}

List<int> stringToDisplayIntList(String str){
  // List allS = str.split(' ');
  // List<int> hexBytes = [];
  // allS.forEach((element) {
  //   int? hex = ByteTool.hexToInt2(element);
  //   hexBytes.add(hex!);
  // });
  // return hexBytes;
  return HEX.decode(str);
}




