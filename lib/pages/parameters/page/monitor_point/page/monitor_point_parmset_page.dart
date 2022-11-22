
import 'dart:async';
import 'package:debug_tools_wifi/common/bottom_sheet_tool.dart';
import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/pages/monitor/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/monitor_point_parmset_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/aperture_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/flowmeter_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/generator_power_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/water_level_page.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonitorPointParmSetPage extends StatefulWidget {
  const MonitorPointParmSetPage({Key? key}) : super(key: key);

  @override
  State<MonitorPointParmSetPage> createState() => _MonitorPointParmSetPageState();
}

class _MonitorPointParmSetPageState extends State<MonitorPointParmSetPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  // 数据参数
  Map baseInfo = Get.arguments;
  // 数据点类型
  int setType = 0;
  // 保存数据
  List allData = [];
  // 定时器
  Timer? _timer;
  // 是否开启定时刷新实时数据
  bool _isTimerStart = true;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    monitorController = Get.find<MonitorController>();
    this.setType = baseInfo['type'];
    initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  /// 初始化加载一次数据
  void initData() async {
    refreshData();

    await Future.delayed(const Duration(milliseconds: 5000));
    // if (_timer == null) {
    //   _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
    //     print('timer');
    //     if (!_isTimerStart) return;
    //     //freshFlowNumberData();
    //   });
    // }

  }

  void refreshData() async{
    // 水位测量1
    await Future.delayed(const Duration(milliseconds: 100),(){
      String string1 = DataTool.sendGetMessageData('0${baseInfo['index']}', '50', 36);
      monitorController.sendMessage(string1);
    });
    // 水位测量2
    await Future.delayed(const Duration(milliseconds: 100), (){
      String string2 = DataTool.sendGetMessageData('0${baseInfo['index']}', '70', 36);
      monitorController.sendMessage(string2);
    });
    // 实时流量值
    await Future.delayed(const Duration(milliseconds: 100));
    freshFlowNumberData();
    // 检测点参数
    await Future.delayed(const Duration(milliseconds: 300));
    String string = DataTool.sendGetMessageData('0${baseInfo['index']}', '10', 36);
    print('string:$string');
    monitorController.sendMessage(string);

    _isTimerStart = true;
  }

  void freshFlowNumberData() {
    String addL = '08';
    switch (baseInfo['index']) {
      case 1 : addL = '08';
      break;
      case 2 : addL = '14';
      break;
      case 3 : addL = '20';
      break;
      case 4 : addL = '2C';
      break;
      case 5 : addL = '38';
      break;
      case 6 : addL = '44';
      break;
    }
    String string3 = DataTool.sendGetMessageData('00', addL, 4);
    print('string3:$string3');
    monitorController.sendMessage(string3);
  }

  // void data(){
  //   if(monitorController.flowNumberDataList.length == 0) {
  //     return DefaultNoDataViewWidget();
  //   }
  //   if(monitorController.monitorPointSetList.length == 0) {
  //     return DefaultNoDataViewWidget();
  //   }
  //   // 获取监测类型
  //   List codeData = monitorController.monitorPointSetList[0];
  //   RegisterData codeReg = codeData.first;
  //   List<int> codeList = codeData.last;
  //   this.setType = ByteTool.codeToInt(codeList);

  //   int zero = 0;

  //   for (int i = 0; i < monitorController.monitorPointSetList.length; i ++) {
  //     List data = monitorController.monitorPointSetList[i];
  //     RegisterData registerData = data.first;
  //     List<int> list = data.last;
  //     String str = intListToDisplayString(list);
  //     if(allData.length  < monitorController.monitorPointSetList.length && monitorController.funcType == 3) {
  //       _isTimerStart = true;
  //       allData.add(str);
  //     }
  //   }

  //   int waterLevelCount = 2;

  //   // 类型为泄流匣添加一个开度设置
  //   int kaidu = this.setType == 0 ? 1 : 0;

  //   // 流量计参数
  //   int liuliangji = 0;
  //   int liuliangjiStart = 0;
  //   int fadianjiCount = 0;
  //   int fadianjiStart = 0;
  //   if(this.setType == 1) {
  //     List start = monitorController.monitorPointSetList[1];
  //     List<int> startList = start.last;
  //     liuliangjiStart = ByteTool.codeToInt(startList);

  //     List liuliangejiData = monitorController.monitorPointSetList[2];
  //     List<int> liuliangjiList = liuliangejiData.last;
  //     liuliangji = ByteTool.codeToInt(liuliangjiList);
  //   }

  //   // 发电机功率
  //   if (this.setType == 3) {
  //     List start = monitorController.monitorPointSetList[1];
  //     List<int> startList = start.last;

  //     fadianjiStart = ByteTool.codeToInt(startList)+1;

  //     List fadianjiData = monitorController.monitorPointSetList[2];
  //     List<int> fadianjiList = fadianjiData.last;
  //     if (allData.length > 0) {
  //       fadianjiList = stringToDisplayIntList(allData[2]);
  //     } else {
  //       fadianjiList = fadianjiData.last;
  //     }
  //     fadianjiCount = ByteTool.codeToInt(fadianjiList);
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('监测点${baseInfo['index']}参数'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: GetBuilder<MonitorController>(
                  builder: (monitorController) {
                  if(monitorController.flowNumberDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  if(monitorController.monitorPointSetList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  // 获取监测类型
                  List codeData = monitorController.monitorPointSetList[0];
                  RegisterData codeReg = codeData.first;
                  List<int> codeList = codeData.last;
                  this.setType = ByteTool.codeToInt(codeList);

                  int zero = 0;

                  for (int i = 0; i < monitorController.monitorPointSetList.length; i ++) {
                    List data = monitorController.monitorPointSetList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.monitorPointSetList.length && monitorController.funcType == 3) {
                      _isTimerStart = true;
                      allData.add(str);
                    }
                  }

                  int waterLevelCount = 2;

                  // 类型为泄流匣添加一个开度设置
                  int kaidu = this.setType == 0 ? 1 : 0;

                  // 流量计参数
                  int liuliangji = 0;
                  int liuliangjiStart = 0;
                  int fadianjiCount = 0;
                  int fadianjiStart = 0;
                  if(this.setType == 1) {
                    List start = monitorController.monitorPointSetList[1];
                    List<int> startList = start.last;
                    liuliangjiStart = ByteTool.codeToInt(startList);

                    List liuliangejiData = monitorController.monitorPointSetList[2];
                    List<int> liuliangjiList = liuliangejiData.last;
                    liuliangji = ByteTool.codeToInt(liuliangjiList);
                  }

                  // 发电机功率
                  if (this.setType == 3) {
                    List start = monitorController.monitorPointSetList[1];
                    List<int> startList = start.last;

                    fadianjiStart = ByteTool.codeToInt(startList)+1;

                    List fadianjiData = monitorController.monitorPointSetList[2];
                    List<int> fadianjiList = fadianjiData.last;
                    if (allData.length > 0) {
                      fadianjiList = stringToDisplayIntList(allData[2]);
                    } else {
                      fadianjiList = fadianjiData.last;
                    }
                    fadianjiCount = ByteTool.codeToInt(fadianjiList);
                  }

                  return Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('监测类型：${monitorType[this.setType] ?? ''}',style: TextStyle(color: Colors.red),),
                          ),
                        ),
                        onTap: (){
                          monitorTypeChanged(0,null,10000);
                        },
                      ),

                      Expanded(
                        child:  ListView.builder(
                          itemCount: monitorController.monitorPointSetList.length-1+ waterLevelCount + kaidu+ liuliangji + fadianjiCount + monitorController.flowNumberDataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var value;
                            String title = '';
                            String contentText = '';
                            RegisterData? tentReg;
                            if(index > monitorController.monitorPointSetList.length-2) {
                              int level = index - (monitorController.monitorPointSetList.length-2);
                              if(level <= waterLevelCount) {
                                List waterData = [];//monitorController.waterLevelList[0];
                                level == 1 ? waterData.addAll(monitorController.waterLevelList[0]) : waterData.addAll(monitorController.waterLevelTwoList[0]);
                                List<int> waterList = waterData.last;
                                int waterValue = ByteTool.codeToInt(waterList);
                                title = '水位测量$level设置';
                                waterValue > 5 ? title = title+'（未启用）' : title = title+'（启用）';
                              } else if(level > waterLevelCount && level <= waterLevelCount+kaidu) {
                                title = '开度测量设置';
                              } else if (this.setType == 1 && level > waterLevelCount+kaidu && level<= waterLevelCount+kaidu+liuliangji) {
                                int lljIndex = level-waterLevelCount-kaidu-1;
                                title = '流量计${liuliangjiStart+lljIndex}设置';

                              } else if (this.setType == 3 && level > waterLevelCount+kaidu && level<= waterLevelCount+kaidu+fadianjiCount) {
                                int lljIndex = level-waterLevelCount-kaidu-1;
                                title = '功率测量${fadianjiStart+lljIndex}设置';

                              }

                            } else {
                              List data = monitorController.monitorPointSetList[index+1];
                              RegisterData registerData = data.first;
                              tentReg = registerData;
                              List<int> list = [];
                              if(allData.length > 0) {
                                String allIndex = allData[index+1];
                                list = stringToDisplayIntList(allIndex);
                              } else {
                                list = data.last;
                              }
                              registerData.multiple > 1
                                  ? value =
                                  ByteTool.codeToInt(list) / registerData.multiple
                                  : value = ByteTool.codeToInt(list);

                              if (this.setType == 3 && index == 0) {
                                // 功率测量起始点号
                                value = value+1;
                              }
                              contentText = value.toStringAsFixed(
                                  registerData.multiple
                                      .toString()
                                      .length - 1) +' '+registerData.unit;

                              if(this.setType == 0 && index == 5) {
                                // 底坎类型
                                value == 0 ? contentText = '宽顶堰' :value == 1 ? contentText ='实用堰':contentText ='';
                              }
                              title = registerData.content;

                              if (this.setType == 2 && registerData.content == '底坡') {
                                contentText = '1 : $contentText';
                              }
                            }

                            if (index == monitorController.monitorPointSetList.length-1+ waterLevelCount + kaidu+ liuliangji + fadianjiCount) {
                              title = '流量值';
                              if (monitorController.flowNumberDataList.length > 0) {
                                List flowNL = monitorController.flowNumberDataList[0];
                                RegisterData flowRegD = flowNL.first;
                                List<int> list = flowNL.last;
                                contentText = (ByteTool.codeToInt(list) / flowRegD.multiple).toStringAsFixed(
                                    flowRegD.multiple
                                        .toString()
                                        .length - 1) +' '+flowRegD.unit;
                              } else {
                                contentText = '';
                              }

                            }



                            return InkWell(

                              child:(tentReg != null && tentReg.content == '0') ? CustomRowListile(rowType: RowType.nodataRow,) : CustomRowListile(
                                  rowType: RowType.defaultLDRow,
                                  titleName: title,
                                  contentStr: contentText),
                              onTap: () {
                                _isTimerStart = false;
                                if (index >
                                    monitorController
                                            .monitorPointSetList.length -
                                        2) {
                                  // 水位测量设置
                                  int level = index -
                                      (monitorController
                                              .monitorPointSetList.length -
                                          2);

                                  if (level <= waterLevelCount) {
                                    // 水位测量
                                    Get.to(() => WaterlevelPage(), arguments: {
                                      'monitorPoint': baseInfo['index'],
                                      'levelIndex': level
                                    })!
                                        .then((value) => refreshData());
                                  } else if (level > waterLevelCount &&
                                      level <=
                                          fadianjiCount + waterLevelCount) {
                                    // 发电机功率
                                    int fdjIndex = level - waterLevelCount - 1 + fadianjiStart;
                                    Get.to(() => GeneratorPowerPage(), arguments: {'powerIndex': fdjIndex})!.then((value) => refreshData());
                                  } else if (level > waterLevelCount &&
                                      level <= waterLevelCount + kaidu) {
                                    // 开度测量
                                    Get.to(() => AperturePage(), arguments: {'monitorPoint': baseInfo['index']})!.then((value) => refreshData());
                                  } else if (level > waterLevelCount + kaidu &&
                                      level <= waterLevelCount + kaidu + liuliangji) {
                                    // 流量计
                                    int lljIndex = level - waterLevelCount - kaidu - 1 + liuliangjiStart;
                                    Get.to(() => FlowMeterPage(), arguments: {'lljIndex': lljIndex})!.then((value) => refreshData());
                                  }
                                  return;
                                }
                                List data = monitorController.monitorPointSetList[index + 1];
                                RegisterData registerData = data.first;
                                if (registerData.isOnlyRead) return;
                                _isTimerStart = false;
                                if (this.setType == 0 && index == 5) {
                                  // 底坎类型
                                  monitorTypeChanged(2, registerData, index);
                                  return;
                                }

                                if (this.setType == 3 && index == 0) {
                                  monitorTypeChanged(1, registerData, index);
                                  return;
                                }
                                // 根据监测点，修改地址

                                registerData.addressHigh = '0${baseInfo['index']}';
                                funcSendMonitor(registerData, index);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
              ),
              RxdWidget(
                xiafaFuncation: (){
                  if (allData.length == 0) {
                    progressShowFail(context, '下发速度过快，请稍后再发');
                    return;
                  }
                  String message = '';
                  allData.forEach((element) {
                    message.length == 0 ? message = element : message = message +' ' + element;
                  });
                  String addH = '0${baseInfo['index']}';
                  String headerStr = DataTool.sendWriteMessageMultipleData(addH, '10', 36);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  allData = [];
                  monitorController.sendMessage(dataStr);
                },
                zhaocheFunction: (){
                  allData = [];
                  String string = DataTool.sendGetMessageData('0${baseInfo['index']}', '10', 36);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendMonitor(RegisterData registerData, int index) {
    showDialog(
        context: this.context,
        // barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogTextFieldWidget(
            title: registerData.content,
            content: '',
            tfHodText: registerData.defaultString,
            cancelText: '取消',
            confirmText: '确定',
            cancelFun: () {
              _isTimerStart = true;
            },
            confirmFun: (text) async{
              if (registerData.isASCII) {
                if (!(text.toString().length >= registerData.minValue && text.toString().length <= registerData.maxValue)) {
                  progressShowFail(context, registerData.defaultString);
                  return;
                }
              } else {
                if (!(double.parse(text.toString()) >= registerData.minValue && double.parse(text.toString()) <= registerData.maxValue)) {
                  progressShowFail(context, registerData.defaultString);
                  return;
                }
              }
              if(!registerData.isMinus && double.parse(text) < 0 && !registerData.isASCII && !registerData.isIpAddress) {
                progressShowFail(context, '值不能为负数');
                return;
              }
              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                String valueData = text.toString();
                if (!registerData.isASCII) {
                  int textValue = ((double.parse(valueData) *registerData.multiple).truncate());
                  valueData = textValue.toString();
                }
                // String dataStr = DataTool.sendWriteMessageData(registerData, text);
                String valueStr = DataTool.dataByteELibMessage(false, registerData.length, valueData);
                print(valueStr);
                allData.setRange(index+1, index+1+1, [valueStr]);
                _isTimerStart = true;
                setState(() {

                });
                return;
              });
            },
          );
        }
    );
  }

  void monitorTypeChanged(int type, RegisterData? registerData,int indexT) {
    //   0: 类型,
    //   1: 发电机功率起始点号,
    //   2: '底坎类型,
    _isTimerStart = false;
    var list = [];
    type == 0
        ? list = ['泄流闸', '泄流管道', '泄流明渠', '发电机功率', '量水堰', '泄水孔']
        : type == 1
            ? list = ['数据点号1','数据点号2','数据点号3','数据点号4','数据点号5','数据点号6','数据点号7']
            : list = ['宽顶堰', '实用堰'];
    showBottomSheetTool().showSingleRowPicker(
      //上下文
        context,
        //默认的索引
        normalIndex: 0,
        title: "请选择类型",
        //要显示的列表
        //可自定义数据适配器
        //adapter: PickerAdapter(),
        data: list,
        //选择事件的回调
        clickCallBack: (int index, var str) {
          if (type == 0) {
            // 修改监测类型
            String dataStr = DataTool.sendWriteMessageMultipleData('0${baseInfo['index']}', '10', 4);
            dataStr = dataStr+'00 00 00'+' '+'0$index';
            debugPrint(dataStr);
            allData = [];
            monitorController.sendMessage(dataStr);
          } else if(type == 1 || type == 2){
            String valueStr = DataTool.dataByteELibMessage(false, registerData!.length, '$index');
            // 处理数据发送
            allData.setRange(indexT+1, indexT+1+1, [valueStr]);
            setState(() {

            });
            return;
          }

        });
  }
}
