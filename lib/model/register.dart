
/// 寄存器数据
class RegisterData{
  /// 寄存器地址
  int registerAddressHigh = 0;
  int registerAddressLow = 0;
  // 寄存器起始地址
  String addressHigh = '';
  String addressLow = '';
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
  ///
  bool isOnlyRead = false;
  /// 单位
  String unit = '';
  /// 是否是ip地址
  bool isIpAddress = false;
  /// 最小值
  double minValue = 0;
  /// 最大值
  double maxValue = 0;
  /// 默认提示
  String defaultString = '';
  /// 是否可为负数
  bool isMinus = false;


  RegisterData({
    required this.registerAddressHigh,
    required this.registerAddressLow,
    required this.content,
    this.length = 4,
    this.addressHigh = '',
    this.addressLow = '',
    this.instructions = '',
    this.multiple = 1,
    this.value = const <int>[],
    this.isASCII = false,
    this.unit = '',
    this.isOnlyRead = false,
    this.isIpAddress = false,
    this.minValue = 0,
    this.maxValue = 0,
    this.defaultString = '',
    this.isMinus = false,
  });
}

