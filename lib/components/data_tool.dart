
import 'dart:math';

import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:flutter/material.dart';

class DataTool {

  static String asciiByteToString(int dataLength ,String data) {
    String dataStr = '';
    // 字符串转成ASCII16进制
    List<String> dataList = ByteTool.byteListArray(data);
    int count = dataLength - dataList.length;
    // 字节数不够字符串后面以00补齐
    for (int i = 0; i< count; i++) {
      dataList.add('00');
    }
    // 拼凑数据字符串
    for (int i = 0; i<dataList.length; i++) {
      String string = dataList[i];
      dataStr.length == 0 ? dataStr = string : dataStr = dataStr + ' ' + string;
    }
    return dataStr;
  }

  static String dataByteToString(int dataLength, String data) {
    String dataStr = '';
    // 数字字符串转16进制
    String stringV = int.parse(data).toRadixString(16);
    String dataValue = stringV;
    if(dataValue.length ==1) {
      dataValue = '0'+dataValue;
    } else {
      if (dataValue.length.isEven) {
        String oldS = stringV;
        for (int i = 0; i < oldS.length/2;i++) {
          String aaaa = oldS.substring(2*i, 2*(i+1));
          i == 0 ? dataValue = aaaa : dataValue = dataValue + ' ' + aaaa;
        }
      } else {
        String bbbb = stringV.substring(0, 1);
        String cccc = stringV.substring(1);
        dataValue = '0$bbbb';
        print('bbbb:$bbbb cccc:$cccc');
        for (int i = 0; i < cccc.length/2;i++) {
          String aaaa = cccc.substring(2*i, 2*(i+1));
          dataValue = dataValue + ' ' + aaaa;
        }
      }
    }
    // 字节数大于两位的时候前面加'00'补齐
    if(dataLength >= 2) {
      List le = dataValue.split(' ');
      for (int i = 0; i<dataLength - le.length; i++) {
        dataStr.length == 0 ? dataStr = '00' : dataStr = dataStr +' ' + '00';
      }
      dataStr = dataStr +' ' + dataValue;
    } else {
      dataStr = dataValue;
    }
    return dataStr;
  }

  static String dataByteSixTToString(int dataLength, String data) {
    String dataStr = '';
    // 数字字符串转16进制
    String stringV = data;
    String dataValue = data;
    if(dataValue.length ==1) {
      dataValue = '0'+dataValue;
    } else {
      if (dataValue.length.isEven) {
        String oldS = stringV;
        for (int i = 0; i < oldS.length/2;i++) {
          String aaaa = oldS.substring(2*i, 2*(i+1));
          i == 0 ? dataValue = aaaa : dataValue = dataValue + ' ' + aaaa;
        }
      } else {
        String bbbb = stringV.substring(0, 1);
        String cccc = stringV.substring(1);
        dataValue = '0$bbbb';
        print('bbbb:$bbbb cccc:$cccc');
        for (int i = 0; i < cccc.length/2;i++) {
          String aaaa = cccc.substring(2*i, 2*(i+1));
          dataValue = dataValue + ' ' + aaaa;
        }
      }
    }
    // 字节数大于两位的时候前面加'00'补齐
    if(dataLength >= 2) {
      List le = dataValue.split(' ');
      for (int i = 0; i<dataLength - le.length; i++) {
        dataStr.length == 0 ? dataStr = '00' : dataStr = dataStr +' ' + '00';
      }
      dataStr = dataStr +' ' + dataValue;
    } else {
      dataStr = dataValue;
    }
    return dataStr;
  }

  static String ipAddressToString(int dataLength, List data) {
    String dataListStr = '';
    // 判断数据是否是ASCII类型
    // 数字字符串转16进制
    data.forEach((element) {
      String string = int.parse(element.toString()).toRadixString(16);
      if(string.length ==1) {
        string = '0'+string;
      }
      dataListStr.length == 0 ? dataListStr = string : dataListStr = dataListStr+' ' + string;
    });
    // 字节数大于两位的时候前面加'00'补齐
    String defaultStr = '';
    if(dataLength >= 2) {
      for (int i = 0; i<dataLength - data.length; i++) {
        defaultStr.length == 0 ? defaultStr = '00' : defaultStr = defaultStr +' ' + '00';
      }
      defaultStr.length > 0? dataListStr = defaultStr +' ' + dataListStr : debugPrint('');
    }
    return dataListStr;
  }

  // 处理写寄存器的数据
  static String dataByteMessage (RegisterData registerData, String data) {
    String dataStr = '';
    // 判断数据是否是ASCII类型
    if (!registerData.isASCII) {
      // 数字字符串转16进制
      String stringV = int.parse(data).toRadixString(16);
      String dataValue = stringV;
      if(dataValue.length ==1) {
        dataValue = '0'+dataValue;
      } else {
        if (dataValue.length.isEven) {
          String oldS = stringV;
          for (int i = 0; i < oldS.length/2;i++) {
            String aaaa = oldS.substring(2*i, 2*(i+1));
            i == 0 ? dataValue = aaaa : dataValue = dataValue + ' ' + aaaa;
          }
        } else {
          String bbbb = stringV.substring(0, 1);
          String cccc = stringV.substring(1);
          dataValue = '0$bbbb';
          print('bbbb:$bbbb cccc:$cccc');
          for (int i = 0; i < cccc.length/2;i++) {
            String aaaa = cccc.substring(2*i, 2*(i+1));
           dataValue = dataValue + ' ' + aaaa;
          }
        }
      }
      // 字节数大于两位的时候前面加'00'补齐
      if(registerData.length >= 2) {
        List le = dataValue.split(' ');
        for (int i = 0; i<registerData.length - le.length; i++) {
          dataStr.length == 0 ? dataStr = '00' : dataStr = dataStr +' ' + '00';
        }
        dataStr = dataStr +' ' + dataValue;
      } else {
        dataStr = dataValue;
      }

    } else {
      // 字符串转成ASCII16进制
      List<String> dataList = ByteTool.byteListArray(data);
      int count = registerData.length - dataList.length;
      // 字节数不够字符串后面以00补齐
      for (int i = 0; i< count; i++) {
        dataList.add('00');
      }
      // 拼凑数据字符串
      for (int i = 0; i<dataList.length; i++) {
        String string = dataList[i];
        dataStr.length == 0 ? dataStr = string : dataStr = dataStr + ' ' + string;
      }
    }
    return dataStr;
  }

  // 处理写寄存器的数据
  static String dataByteELibMessage (bool isASCII, int dataLength, String data) {
    String dataStr = '';
    // 判断数据是否是ASCII类型
    if (!isASCII) {
      // 数字字符串转16进制
      String stringV = int.parse(data).toRadixString(16);
      String dataValue = stringV;
      if(dataValue.length ==1) {
        dataValue = '0'+dataValue;
      } else {
        if (dataValue.length.isEven) {
          String oldS = stringV;
          for (int i = 0; i < oldS.length/2;i++) {
            String aaaa = oldS.substring(2*i, 2*(i+1));
            i == 0 ? dataValue = aaaa : dataValue = dataValue + ' ' + aaaa;
          }
        } else {
          String bbbb = stringV.substring(0, 1);
          String cccc = stringV.substring(1);
          dataValue = '0$bbbb';
          print('bbbb:$bbbb cccc:$cccc');
          for (int i = 0; i < cccc.length/2;i++) {
            String aaaa = cccc.substring(2*i, 2*(i+1));
            dataValue = dataValue + ' ' + aaaa;
          }
        }
      }
      // 字节数大于两位的时候前面加'00'补齐
      if(dataLength >= 2) {
        List le = dataValue.split(' ');
        for (int i = 0; i<dataLength - le.length; i++) {
          dataStr.length == 0 ? dataStr = '00' : dataStr = dataStr +' ' + '00';
        }
        dataStr = dataStr +' ' + dataValue;
      } else {
        dataStr = dataValue;
      }
      // String string = int.parse(data).toRadixString(16);
      // if(string.length ==1) {
      //   string = '0'+string;
      // }
      // // 字节数大于两位的时候前面加'00'补齐
      // if(dataLength >= 2) {
      //   for (int i = 0; i<dataLength - 1; i++) {
      //     dataStr.length == 0 ? dataStr = '00' : dataStr = dataStr +' ' + '00';
      //   }
      //   dataStr = dataStr +' ' + string;
      // } else {
      //   dataStr = string;
      // }

    } else {
      // 字符串转成ASCII16进制
      // List<String> dataList = ByteTool.byteListArray(data);
      // int count = registerData.length - dataList.length;
      // // 字节数不够字符串后面以00补齐
      // for (int i = 0; i< count; i++) {
      //   dataList.add('00');
      // }
      // // 拼凑数据字符串
      // for (int i = 0; i<dataList.length; i++) {
      //   String string = dataList[i];
      //   dataStr.length == 0 ? dataStr = string : dataStr = dataStr + ' ' + string;
      // }
    }
    return dataStr;
  }

  // 写寄存器的命令（单个参数）
  static String sendWriteMessageData(RegisterData registerData, String data){
    String msgStr = '';
    // 事物标识
    String address = registerData.addressHigh+ ' ' + registerData.addressLow;
    // 协议
    String protocol = '00 00';
    // 长度
    String changdu = (registerData.length + 7).toRadixString(16);
    changdu.length == 1 ? changdu = '0'+changdu:changdu=changdu;
    String length = '00'+ ' ' + changdu;
    // 单元标识
    String unitId = '68';
    // 功能码
    String funcode = '10';
    // 起始寄存器
    String startCode = registerData.addressHigh + ' '  + registerData.addressLow;
    int len = (registerData.length~/2);
    // 数量
    String hex = ByteTool.hexStr(len);
    print(hex);
    String num = '00'+' '+hex;
    // 字节数
    String byteL = ByteTool.hexStr(registerData.length);
    // 功能码
    String dataStr = DataTool.dataByteMessage(registerData, data);

    msgStr = address +
        ' ' +
        protocol +
        ' ' +
        length +
        ' ' +
        unitId +
        ' ' +
        funcode +
        ' ' +
        startCode +
        ' ' +
        num +
        ' ' +
        byteL +
        ' ' +
        dataStr;

    return msgStr;
  }

  // 写寄存器的命令(参数是数组)（IP地址）
  static String sendWriteMessageListData(RegisterData registerData, List data){
    String msgStr = '';
    // 事物标识
    String address = registerData.addressHigh+ ' ' + registerData.addressLow;
    // 协议
    String protocol = '00 00';
    // 长度
    String changdu = (registerData.length + 7).toRadixString(16);
    changdu.length == 1 ? changdu = '0'+changdu:changdu=changdu;
    String length = '00'+ ' ' + changdu;
    // 单元标识
    String unitId = '68';
    // 功能码
    String funcode = '10';
    // 起始寄存器
    String startCode = registerData.addressHigh + ' '  + registerData.addressLow;
    int len = (registerData.length~/2);
    // 数量
    String hex = ByteTool.hexStr(len);
    print(hex);
    String num = '00'+' '+hex;
    // 字节数
    String byteL = ByteTool.hexStr(registerData.length);
    // 功能码

    String dataListStr = '';
    // 判断数据是否是ASCII类型
    // 数字字符串转16进制
    data.forEach((element) {
      String string = int.parse(element.toString()).toRadixString(16);
      if(string.length ==1) {
        string = '0'+string;
      }
      dataListStr.length == 0 ? dataListStr = string : dataListStr = dataListStr+' ' + string;
    });
    // 字节数大于两位的时候前面加'00'补齐
    String defaultStr = '';
    if(registerData.length >= 2) {
      for (int i = 0; i<registerData.length - data.length; i++) {
        defaultStr.length == 0 ? defaultStr = '00' : defaultStr = defaultStr +' ' + '00';
      }
      defaultStr.length > 0? dataListStr = defaultStr +' ' + dataListStr : debugPrint('');
    }

    msgStr = address +
        ' ' +
        protocol +
        ' ' +
        length +
        ' ' +
        unitId +
        ' ' +
        funcode +
        ' ' +
        startCode +
        ' ' +
        num +
        ' ' +
        byteL +
        ' ' +
        dataListStr;

    return msgStr;
  }

  // 写寄存器的命令（多个参数,无功能码，功能码最后拼接）
  static String sendWriteMessageMultipleData(String addressH,String addressLow, int dataLength){
    String msgStr = '';
    // 事物标识
    String address = addressH+ ' ' + addressLow;
    // 协议
    String protocol = '00 00';
    // 长度
    String changdu = (dataLength + 7).toRadixString(16);
    changdu.length == 1 ? changdu = '0'+changdu:changdu=changdu;
    String length = '00'+ ' ' + changdu;
    // 单元标识
    String unitId = '68';
    // 功能码
    String funcode = '10';
    // 起始寄存器
    String startCode = addressH + ' '  + addressLow;
    int len = (dataLength~/2);
    // 数量
    String hex = ByteTool.hexStr(len);
    print(hex);
    String num = '00'+' '+hex;
    // 字节数
    String byteL = ByteTool.hexStr(dataLength);
    // 功能码
    // String dataStr = DataTool.dataByteMessage(registerData, data);
    // String datsS = DataTool.dataByteELibMessage(false, dataLength, data);

    msgStr = address +
        ' ' +
        protocol +
        ' ' +
        length +
        ' ' +
        unitId +
        ' ' +
        funcode +
        ' ' +
        startCode +
        ' ' +
        num +
        ' ' +
        byteL +
        ' ' ;

    return msgStr;
  }

  // 读寄存器的命令
  static String sendGetMessageData (String startH, String startL, int allLength) {
    String msgStr = '';
    // 事物标识
    String address = startH+ ' ' + startL;
    // 协议
    String protocol = '00 00';
    // 长度
    String length = '00 06';
    // 单元标识
    String unitId = '68';
    // 功能码
    String funcode = '03';
    // 起始寄存器
    String startCode = startH + ' '  + startL;
    // 数量
    int len = (allLength~/2);
    String hex = ByteTool.hexStr(len);
    print(hex);
    String num = '00'+' '+hex;

    msgStr = address +
        ' ' +
        protocol +
        ' ' +
        length +
        ' ' +
        unitId +
        ' ' +
        funcode +
        ' ' +
        startCode +
        ' ' +
        num ;

    return msgStr;
  }

  static String minusTwoDataRollbackTenByte (int num) {
    int value = num;
    int absValue = value.abs();
    String twoHex = absValue.toRadixString(2);
    String dataTwo ='';
    int count = twoHex.length;
    for(int i = 0; i < count; i++) {
      String str = twoHex[i];
      if (str == '0') {
        str = '1';
      } else {
        str = '0';
      }
      dataTwo += str;
    }
    print(twoHex);
    // 取反
    int indexC = 0;
    for (int i = count-1; i >= 0; i--) {
      String opStr = dataTwo[i];
      if (opStr == '0') {
        indexC = i;
        break;
      }
    }
    String buStr = dataTwo.substring(indexC);
    String buResult ='';
    int buCount = buStr.length;
    for (int i = 0; i < buCount; i++) {
      String str = buStr[i];
      if (str == '0') {
        str = '1';
      } else {
        str = '0';
      }
      buResult += str;
    }

    print(dataTwo.substring(5));
    print(dataTwo.substring(0,5));
    String headStr = dataTwo.substring(0,indexC);
    String dataResultStr = headStr +buResult;

    int aaaa = dataResultStr.length % 4;
    print(aaaa);

    int bbbb = dataResultStr.length ~/ 4;
    print(bbbb);

    int allCount = aaaa > 0 ? 1 + bbbb : bbbb;
    print('allCount$allCount');
    // List allData = [];
    int l = 0;
    int al = 0;
    List allResultData = [];
    for (int i = 0; i < allCount; i++) {
      if (aaaa > 0) {
        if (i == 0) {
          l = 0;
          al = 3;
        } else {
          l = 3+4*(i-1);
          al = 3+4*i;
        }
      } else {
        i > 0 ? l = 4*i - 1 : l = 0;
        al = 4+4*i;
      }
      String hexStr = dataResultStr.substring(l, al);
      // allData.addAll(hexStr);
      allResultData.add(hexStr);
      print(hexStr);
      print(dataResultStr);
    }
    print(allResultData);


    List datattt = [];
    for (int i = 0; i< allResultData.length; i++) {
      String dataS = allResultData[i];
      print('dataS$dataS');
      int allSum = 0;
      for (int i = 0; i < dataS.length; i++) {
        String str = dataS[i];
        int valuePow = pow(2, (dataS.length - 1 - i)).toInt() * int.parse(str);
        print('valuePow$valuePow');
        allSum += valuePow;
      }
      datattt.add(allSum);
    }

    print('datattt:$datattt');

    String hexSixeStr = '';
    datattt.forEach((element) {
      int data = element;
      String sss = data.toRadixString(16);
      hexSixeStr += sss;
    });

    print(hexSixeStr);

    String valuedd = DataTool.dataByteSixTToString(4, hexSixeStr);
    print('valuedd:$valuedd');
  //   int sum = 0;
  //   for (int i = 0; i < dataResultStr.length; i++) {
  //     String str = dataResultStr[i];
  //     int valuePow = pow(2, (dataResultStr.length - 1 - i)).toInt() * int.parse(str);
  //     print(valuePow);
  //     sum += valuePow;
  //   }
  //   print(sum);
  //   return sum;
    return valuedd;
  }
}