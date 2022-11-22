import 'dart:math';

import 'package:debug_tools_wifi/common/bottom_sheet_tool.dart';
import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/model/water_level_data.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlowMeterPage extends StatefulWidget {
  const FlowMeterPage({Key? key}) : super(key: key);

  @override
  State<FlowMeterPage> createState() => _FlowMeterPageState();
}

class _FlowMeterPageState extends State<FlowMeterPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  int lljIndex = Get.arguments['lljIndex'];

  List allData = [];

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    monitorController = Get.find<MonitorController>();
    initData();
  }

  /// 初始化加载一次数据
  void initData() async {
    await Future.delayed(const Duration(milliseconds: 300));
    String string = DataTool.sendGetMessageData('10', '${lljIndex}0', 28);
    monitorController.sendMessage(string);
  }
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('流量计$lljIndex设置'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: GetBuilder<MonitorController>(builder: (monitorController) {
                  if(monitorController.flowmeterDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  for (int i = 0; i < monitorController.flowmeterDataList.length; i++) {
                    List data = monitorController.flowmeterDataList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < 5 && monitorController.funcType == 3 && !registerData.isOnlyRead) {
                      allData.add(str);
                    }
                  }
                  return ListView.builder(
                    itemCount: monitorController.flowmeterDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List itemData = monitorController.flowmeterDataList[index];
                      RegisterData registerData = itemData.first;
                      // List<int> hexList = itemData.last;
                      List<int> hexList = [];
                      if(allData.length > 0 && index < allData.length) {
                        String allIndex = allData[index];
                        hexList = stringToDisplayIntList(allIndex);
                      } else {
                        hexList = itemData.last;
                      }
                      String content='';
                      if (index == 4) {
                        content = waterLevelType[ByteTool.codeToInt(hexList)] ?? '';
                      } else {
                        /// 获取类型
                        List typeData = monitorController.flowmeterDataList[4];
                        RegisterData typeRegisterData = typeData.first;
                        List<int> typeHexList = typeData.last;
                        int typeIndex = ByteTool.codeToInt(typeHexList);
                        if(index == 2) {
                          if (typeIndex == 0) {
                            content = '0';
                          } else {
                            hexList.forEach((element) {
                              content.length == 0
                                  ? content = element.toString()
                                  : content = content + "." + element.toString();
                            });
                          }
                        } else {
                          content = (ByteTool.codeToInt(hexList)/registerData.multiple).toStringAsFixed(
                              registerData.multiple
                                  .toString()
                                  .length - 1)+registerData.unit;
                        }
                      }
                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: registerData.content,
                          contentStr: content,
                        ),
                        onTap: () {
                          print(index);
                          List itemData = monitorController.flowmeterDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          String low = registerDataT.addressLow;
                          low = low.substring(0, 0) + "$lljIndex" + low.substring(1);
                          registerDataT.addressLow = low;
                          if (index == 4) {
                            lljTypeChanged(registerDataT, index);
                          } else {
                            /// 获取类型
                            List typeData = monitorController.flowmeterDataList[4];
                            RegisterData typeRegisterData = typeData.first;
                            List<int> typeHexList = typeData.last;
                            if (allData.length > 0) {
                              typeHexList = stringToDisplayIntList(allData[4]);
                            } else {
                              typeHexList = typeData.last;
                            }
                            int typeIndex = ByteTool.codeToInt(typeHexList);
                            if(index == 2) {
                              if (typeIndex == 0) {
                                registerDataT.defaultString = '只能设置0';
                                registerDataT.isIpAddress = false;
                                registerDataT.minValue = 0;
                                registerDataT.maxValue = 0;
                              } else {
                                registerDataT.defaultString = '1~255';
                                registerDataT.isIpAddress = false;
                                registerDataT.minValue = 1;
                                registerDataT.maxValue = 255;
                              }
                            } else if(index == 3) {
                              if (typeIndex == 0 || typeIndex == 1 || typeIndex == 3 || typeIndex == 4) {
                                registerDataT.defaultString = '0~1';
                                registerDataT.minValue = 0;
                                registerDataT.maxValue = 1;
                              } else {
                                registerDataT.defaultString = '0～65535';
                                registerDataT.minValue = 0;
                                registerDataT.maxValue = 65535;
                              }
                            }
                            funcSendLLJMonitor(registerDataT, index);
                          }
                        },
                      );
                    },
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
                  String headerStr = DataTool.sendWriteMessageMultipleData('10', '${lljIndex}0', 20);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  allData = [];
                  monitorController.sendMessage(dataStr);
                },
                zhaocheFunction: (){
                  allData = [];
                  String string = DataTool.sendGetMessageData('10', '${lljIndex}0', 28);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendLLJMonitor(RegisterData registerData, int index) {
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogTextFieldWidget(
            title: registerData.content,
            content: '',
            tfHodText: registerData.defaultString,
            cancelText: '取消',
            confirmText: '确定',
            cancelFun: () {
            },
            confirmFun: (text) async{
              if (!registerData.isIpAddress) {
                if (!(double.parse(text.toString()) >= registerData.minValue && double.parse(text.toString()) <= registerData.maxValue)) {
                  progressShowFail(context, registerData.defaultString);
                  return;
                }
                if(!registerData.isMinus && double.parse(text) < 0 && !registerData.isASCII && !registerData.isIpAddress) {
                  progressShowFail(context, '值不能为负数');
                  return;
                }
              }

              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                if (registerData.isIpAddress) {
                  List dataList = text.toString().split('.');
                  if(dataList.length < 4) {
                    progressShowFail(context, '请输入ip地址');
                    return;
                  }
                  String dataStr = DataTool.ipAddressToString(registerData.length, dataList);
                  allData.setRange(index, index+1, [dataStr]);
                  setState(() {

                  });
                  return;
                }
                String string = text.toString();
                int textValue = ((double.parse(string) *registerData.multiple).truncate());
                if (textValue < 0) {
                  if (registerData.isMinus) {
                    int minisData = pow(2, 32).toInt() - textValue.abs();
                    string = minisData.toString();
                  } else {
                    progressShowFail(context, '值不能为负数');
                    return;
                  }
                } else {
                  string = textValue.toString();
                }

                String dataStr = DataTool.dataByteMessage(registerData, string);
                print(dataStr);
                allData.setRange(index, index+1, [dataStr]);
                setState(() {

                });
                return;
              });
            },
          );
        }
    );
  }

  void lljTypeChanged(RegisterData registerData, int indexT) {
    // 0：FMD55_AI
    // 1:ECU500_AI
    // 2:规约1
    // 3:规约2
    // 4:规约3
    // 5:规约4
    var list  = ['FMD55_AI', 'ECU500_1', '规约1','ECU500_2','ECU500_3', '规约2', '规约3'];

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
          debugPrint('index:$index str:$str regsterDataLow:${registerData.addressLow}');
          String dataStr = DataTool.dataByteMessage(registerData, index.toString());
          allData.setRange(indexT, indexT+1, [dataStr]);
          setState(() {

          });
          return;
        });
  }
}
