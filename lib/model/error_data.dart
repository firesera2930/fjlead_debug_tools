
/// 异常信息
class ErrorData{
  int code = 0x00;
  String functionName = '';
  String context = '';

  ErrorData({
    this.code = 0x00,
    this.functionName = '',
    this.context = ''
  });

  /// 根据错误号获取错误信息
  ErrorData getError(int code){
    switch (code) {
      case 0x01: return illegalFunction;
      case 0x02: return illegalDataAddress;
      case 0x03: return illegalDataValue;
      case 0x04: return slaveDeviceError;
      case 0x05: return validationErrors;
      case 0x07: return slaveDeviceBusy;
      case 0x08: return storeParityError;
      case 0x0A: return gatewayPathError;
      default: return illegalFunction;
    }
  }
}

/// 非法功能
ErrorData illegalFunction = ErrorData(
  code: 0x01,
  functionName: '非法功能',
  context: '对于服务器(或从站)来说,询问中接收到的功能码是不可允许的操作,可能是因为功能码仅适用于新设备而被选单元中不可实现同时,还指出服务器(或从站)在错误状态中处理这种请求。'
);

/// 非法数据地址
ErrorData illegalDataAddress = ErrorData(
  code: 0x02,
  functionName: '非法数据地址',
  context: '对于服务器(或从站)来说,询问中接收到的数据地址是不可允许的地址,特别是参考号和传输长度的组合是无效的。对于带有100个寄存器的控制器来说,偏移量96和长度4的请求会成功,而偏移量96和长度5的请求将产生异常码02。'
);

/// 非法数据值
ErrorData illegalDataValue = ErrorData(
  code: 0x03,
  functionName: '非法数据值',
  context: '对于服务器(或从站)来说,询问中接收到的值是不可允许的值,该值指示了组合请求剩余结构中的故障。'
);

/// 从站设备故障
ErrorData slaveDeviceError = ErrorData(
  code: 0x04,
  functionName: '从站设备故障',
  context: '当服务器(或从站)正在设法执行请求的操作时,产生不可重新获得的差错。'
);

/// 确认错误
ErrorData validationErrors = ErrorData(
  code: 0x05,
  functionName: '确认错误',
  context: '与编程命令一起使用,服务器(或从站)已经接收请求,并且正在处理这个请求,但是需要长持续时间进行这些操作,返回这个响应防止在客户机(或主站)中发生超时错误,客户机(或主机)可以继续发送轮询程序完成报文来确认是否完成处理。'
);

/// 从属设备忙
ErrorData slaveDeviceBusy = ErrorData(
  code: 0x07,
  functionName: '从属设备忙',
  context: '与编程命令一起使用，服务器(或从站)正在处理长持续时间的程序命令,当服务器(或从站)空闲时,客户机(或主站)应该稍后重新传給报文。'
);

/// 存储奇偶性差错
ErrorData storeParityError = ErrorData(
  code: 0x08,
  functionName: '存储奇偶性差错',
  context: '与功能码20和21以及参考类型6一起使用,指示扩展文件区不能通过一致性校验。服务器(或从站)设备读取记录文件,但在存储器中发现一个奇偶校验错误。客户机(或主机)可重新发送请求,但可以在服务器(或从站)设备上要求服务。'
);

/// 不可用网关路径
ErrorData gatewayPathError  = ErrorData(
  code: 0x0A,
  functionName: '不可用网关路径',
  context: '与网关一起使用,指示网关不能为处理请求分配输入端口值输出端口的内部通信路径,通常意味着网关是错误配置的或过载的。'
);

