// 字节工具
import 'dart:typed_data';

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

}