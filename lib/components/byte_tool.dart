// 字节工具
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ByteTool {
  
  static int high(int byte16){
    return (byte16 >> 8) & 0x00FF;
  }

  static int low(int byte16){
    return (byte16 >> 0) & 0x00FF;
  }

  static int byte16(int high,int low) {
    return ((high << 8) & 0xFF00) + ((low << 0) & 0x00FF);
  }

  static bool bit(int byte8,int index) {
    return ((byte8 & (1 << index)) > 0) ? true : false;
  }
  static String bitStr(int byte8,int index) {
    return ((byte8 & (1 << index)) > 0) ? '1' : '0';
  }

  /// 报文转数据
  static int messageToData(List<int> message){
    Uint8List resultList = Uint8List.fromList(message);
    ByteData byteData = ByteData.view(resultList.buffer);
    return message.isNotEmpty ? byteData.getInt32(0) : 0;
  }

  //hex ---> int  更简单
  static int? hexToInt2(String hex) {
    int? val;
    if(hex.contains("0x")){
      String desString = hex.substring(2);
      val = int.tryParse("0x$desString");
    }else {
      val = int.tryParse("0x$hex");
    }
    return val;
  }

  static String hexStr(int num) {
    String hex = num.toRadixString(16);
    hex.length == 1 ? hex = '0'+hex : hex = hex;
    return hex;
  }

  // 字符串转16进制ACSCII码
  static String byteList(String code) {
    String res="";
    for (int i = 0; i < code.length; i++) {
       // String str= code.codeUnitAt(i).toRadixString(16);
       res.length > 0 ? res = res+' '+code.codeUnitAt(i).toRadixString(16): res = res+code.codeUnitAt(i).toRadixString(16);
       // print(res);
    }
    debugPrint(res);
    return res;
  }

  // 字符串转16进制ACSCII码
  static List<String> byteListArray(String code) {
    List<String> res=[];
    for (int i = 0; i < code.length; i++) {
      String str= code.codeUnitAt(i).toRadixString(16);
      res.add(str);
    }
    return res;
  }

  /// 16位解析数字 16转10进制
  static int codeToInt(List<int> code){
    Uint8List resultList = Uint8List.fromList(code);
    ByteData byteData = ByteData.view(resultList.buffer);
    return  byteData.getInt32(0);
  }

}