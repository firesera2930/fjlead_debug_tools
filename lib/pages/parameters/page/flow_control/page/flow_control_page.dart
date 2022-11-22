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
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlowControlPage extends StatefulWidget {
  const FlowControlPage({Key? key}) : super(key: key);

  @override
  State<FlowControlPage> createState() => _FlowControlPageState();
}

class _FlowControlPageState extends State<FlowControlPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  List allList = [];

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
    String string = DataTool.sendGetMessageData('07', '00', 40);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('流量控制参数'),
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
                  if(monitorController.flowControlDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  for (int i = 0; i < monitorController.flowControlDataList.length; i ++) {
                    List data = monitorController.flowControlDataList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allList.length  < monitorController.flowControlDataList.length && monitorController.funcType == 3) {
                      allList.add(str);
                    }

                  }

                  return ListView.builder(
                    itemCount: monitorController.flowControlDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List itemData = monitorController.flowControlDataList[index];
                      RegisterData registerData = itemData.first;
                      String content='';
                      if(allList.length > 0) {
                        String allIndex = allList[index];
                        List<int> allHex = stringToDisplayIntList(allIndex);
                        int value= ByteTool.codeToInt(allHex);

                        if (index == 0) {
                          value == 0 ? content = '手动' : content = '自动';
                        } else if (index == 1) {
                          value == 0 ? content = '阀门' : content = '闸门';
                        } else if (index == monitorController.flowControlDataList.length - 1) {
                         content = value == 0 ? '断开':'闭合';
                        } else {
                          content = (ByteTool.codeToInt(allHex)/registerData.multiple).toStringAsFixed(
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
                          List itemData = monitorController.flowControlDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;

                          String allIndex = allList[0];
                          List<int> allHex = stringToDisplayIntList(allIndex);
                          int valueC= ByteTool.codeToInt(allHex);
                          if (valueC == 1 && index == 1) {
                            progressShowFail(context, '自动模式下无法手动控制');
                            return;
                          }

                          if (index == 0 || index == 1) {
                            flowControlTypeChanged(index, registerDataT, index);
                          } else {
                            funcSendFlowControlMonitor(registerDataT, index);
                          }
                        },
                      );
                    },
                  );
                }),
              ),
              RxdWidget(
                xiafaFuncation: () {
                  if (allList.length == 0) {
                    progressShowFail(context, '下发速度过快，请稍后再发');
                    return;
                  }
                  String message = '';
                  allList.forEach((element) {
                    message.length == 0 ? message = element : message = message +' ' + element;
                  });
                  print('message:$message');
                  String headerStr = DataTool.sendWriteMessageMultipleData('07', '00', 40);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  monitorController.sendMessage(dataStr);
                  allList = [];
                },
                zhaocheFunction: () {
                  allList = [];
                  String string = DataTool.sendGetMessageData('07', '00', 40);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),

        ),
      ),
    );
  }

  void funcSendFlowControlMonitor(RegisterData registerData, int index) {
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

              if (!(registerData.isASCII || registerData.isIpAddress)) {
                if (double.parse(text) > registerData.maxValue || double.parse(text) < registerData.minValue) {
                  progressShowFail(context, registerData.defaultString);
                  return;
                }

                if(!registerData.isMinus && double.parse(text) < 0) {
                  progressShowFail(context, '值不能为负数');
                  return;
                }
              }


              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                String valueData = text.toString();
                if (!registerData.isASCII) {
                  int textValue = ((double.parse(valueData) *registerData.multiple).truncate());
                  print('textValue:$textValue');
                  if (textValue < 0) {
                    if (registerData.isMinus) {
                      int minisData = pow(2, 32).toInt() - textValue.abs();
                      valueData = minisData.toString();
                    } else {
                      progressShowFail(context, '值不能为负数');
                      return;
                    }
                  } else {
                    valueData = textValue.toString();
                  }
                  // valueData = textValue.toString();
                }
                // String dataStr = DataTool.sendWriteMessageData(registerData, text);
                String valueStr = DataTool.dataByteELibMessage(false, registerData.length, valueData);
                print('valueStr:$valueStr');

                allList.setRange(index, index+1, [valueStr]);
                // return;
                setState(() {

                });
                return;
              });
            },
          );
        }
    );
  }

  void flowControlTypeChanged(int type, RegisterData registerData, int indexT) {
    var list;
    type == 0
        ? list = ['手动', '自动']
        : list = ['阀门', '闸门']
    ;

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
          String valueStr = DataTool.dataByteELibMessage(false, registerData.length, index.toString());
          allList.setRange(indexT, indexT+1, [valueStr]);
          setState(() {

          });
          return;
        });
  }
}
