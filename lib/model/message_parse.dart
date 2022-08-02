

/// 下行报文
class ClientMessage{

  

}

/// 上行报文
class ServerMessage{

}

/// 功能码
enum FunctionCode{
  read,         // 03 读取
  write,        // 06 单条写入
  multi_write,  // 10 多条写入
}

/// APP是Client，FMD51终端是Server。
/// 事物标识	协议标识	长度	    单元标识	 功能码	 起始高	  起始低	 数量高	  数量低
/// 0x0000	 0x0000	  0x0006	 0x01	     0x03	  0x00	 0x00	   0x00	   0x02

/// 报文解析
class MessageParse{
  
  List<int> code = [];
  /// 长度
  int length = 0;

  MessageParse({
    required this.code,
    required this.length
  });
}

/// 事物处理标识(自增与回复报文对应) 
MessageParse transactionProcessingIdentifier = MessageParse(
  code: [0,0],
  length: 2
);

/// 协议标识
MessageParse protocolIdentifiers = MessageParse(
  code: [0,0],
  length: 2
);

/// 长度
MessageParse messageLength = MessageParse(
  code: [0,0], 
  length: 2
);

/// 单元标识符
MessageParse unitIdentifier = MessageParse(
  code: [104], 
  length: 1
);

/// 字节数
MessageParse byte = MessageParse(
  code: [104], 
  length: 1
);