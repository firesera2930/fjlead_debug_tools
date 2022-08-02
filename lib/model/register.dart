
/// 寄存器数据
class RegisterData{
  /// 寄存器地址
  int registerAddress = 0;
  /// 数据内容
  String content = '';
  /// 字节数
  int length = 0;
  /// 说明
  String instructions = '';
  /// 倍数
  int multiple = 1;
  /// 16进制
  List<int> value = [];


  RegisterData({
    required this.registerAddress,
    required this.content,
    required this.length,
    required this.instructions,
    required this.multiple,
    required this.value
  });
}


