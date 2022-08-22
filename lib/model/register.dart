
/// 寄存器数据
class RegisterData{
  /// 寄存器地址
  int registerAddressHigh = 0;
  int registerAddressLow = 0;
  /// 数据内容
  String content = '';
  /// 字节数
  int length = 4;
  /// 说明
  String instructions = '';
  /// 倍数
  int multiple = 1;
  /// 16进制
  List<int> value = [];
  /// 是否以ASCII解读
  bool isASCII = false;


  RegisterData({
    required this.registerAddressHigh,
    required this.registerAddressLow,
    required this.content,
    this.length = 4,
    this.instructions = '',
    this.multiple = 1,
    this.value = const <int>[],
    this.isASCII = false,
  });
}

