import 'package:debug_tools_wifi/common/bottom_sheet_tool.dart';
import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';

import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/pages/monitor/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ParametersBasePage extends StatefulWidget {
  const ParametersBasePage({Key? key}) : super(key: key);

  @override
  State<ParametersBasePage> createState() => _ParametersBasePageState();
}

class _ParametersBasePageState extends State<ParametersBasePage> {

  late ThemeController themeController;
  late MonitorController monitorController;
  RegisterData? registerData;
  late BuildContext context;

  Map dataMap = {};

  List baseList = [];

  List serList = [];

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
    String string1 = DataTool.sendGetMessageData('01', '00', 28);
    print(string1);
    monitorController.sendMessage(string1);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('基本参数'),
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
                  if(monitorController.baseParmListData.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  if(monitorController.serialPortListData.length == 0) {
                    return DefaultNoDataViewWidget();
                  }

                  for (int i = 0; i < monitorController.baseParmListData.length; i++) {
                    List data = monitorController.baseParmListData[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(baseList.length  < 3 && monitorController.funcType == 3) {
                      baseList.add(str);
                    }
                  }

                  if(monitorController.funcType == 3) {
                    List data = monitorController.serialPortListData[0];
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    serList.add(str);
                  }

                  return ListView.builder(
                    itemCount: monitorController.baseParmListData.length+monitorController.serialPortListData.length,
                    itemBuilder: (BuildContext context, int index) {

                      List itemData =[];
                      if(index == 0) {
                        itemData = monitorController.serialPortListData[index];
                      } else {
                        itemData = monitorController.baseParmListData[index-1];
                      }
                      RegisterData registerData = itemData.first;
                      List<int> hexList = [];

                      if (index > 0) {
                        if(baseList.length > 0) {
                          String allIndex = baseList[index-1];
                          hexList = stringToDisplayIntList(allIndex);
                          print('hexList:$hexList');
                        } else {
                          hexList = itemData.last;
                        }
                      } else {
                        if(serList.length > 0) {
                          String allIndex = serList[index];
                          hexList = stringToDisplayIntList(allIndex);
                        } else {
                          hexList = itemData.last;
                        }
                      }

                      print(hexList);
                      int value= ByteTool.codeToInt(hexList);
                      print(value);
                      String content = '';
                      if (index == 0) {
                        value == 0 ? content = 'RS485-1' : content = 'RS485-2';
                      } else {
                        content = (value / registerData.multiple)
                            .toStringAsFixed(
                            registerData.multiple
                                .toString()
                                .length - 1) +
                            registerData.unit;
                      }

                      if (registerData.isASCII) {
                        content = MonitorData().getCharCodes(hexList).toString().trim();
                      }

                      if(dataMap.length > 0) {
                        int indexM = dataMap['index'];
                        if(indexM == index) {
                          indexM == 0 ? ( dataMap['value'] == '0' ? content = 'RS485-1': content = "RS485-2"): content = dataMap['value']+registerData.unit;
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
                          if (index == 0) {
                            List itemData = monitorController.serialPortListData[index];
                            RegisterData registerDataT = itemData.first;
                            serialPortTypeChanged(registerDataT, index);
                          } else {
                            List itemData = monitorController.baseParmListData[index-1];
                            RegisterData registerDataT = itemData.first;
                            funcSendBaseParmMonitor(registerDataT, index);
                          }

                        },
                      );
                    },
                  );
                }),
              ),
              RxdWidget(
                xiafaFuncation: () {
                  // if (dataMap.length == 0) {
                  //   ToastCommon.showToast('请先做出修改，在操作');
                  //   return;
                  // }
                  String serMsg = serList[0];
                  String serheaderStr = DataTool.sendWriteMessageMultipleData('00', '4E', 4);
                  print(serheaderStr);
                  String serdataStr = serheaderStr+serMsg;
                  print('serdataStr:$serdataStr');
                  serList = [];
                  monitorController.sendMessage(serdataStr);

                  Future.delayed(const Duration(milliseconds: 500),(){

                    String message = '';
                    baseList.forEach((element) {
                      message.length == 0 ? message = element : message = message +' ' + element;
                    });
                    print('message:$message');
                    String headerStr = DataTool.sendWriteMessageMultipleData('01', '00', 28);
                    print(headerStr);
                    String dataStr = headerStr+message;
                    print('dataStr:$dataStr');
                    baseList = [];

                    monitorController.sendMessage(dataStr);

                  });
                  return;
                },
                zhaocheFunction: () {
                  dataMap.clear();
                  String string1 = DataTool.sendGetMessageData('01', '00', 28);
                  monitorController.sendMessage(string1);
                },
              ),
            ],
          ),

        ),
      ),
    );
  }

  void funcSendBaseParmMonitor(RegisterData registerData, int index) {
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

                if(!registerData.isMinus && double.parse(text) < 0   && !registerData.isIpAddress) {
                  progressShowFail(context, '值不能为负数');
                  return;
                }
              }

              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                String string = text.toString();
                // dataMap.clear();
                // dataMap.addAll({'index':index, 'value':string});
                if (registerData.isASCII) {

                } else {
                  int textValue = ((double.parse(string) *registerData.multiple).truncate());
                  string = textValue.toString();
                }
                print(string);
                // return;
                String dataStr = DataTool.dataByteMessage(registerData, string);
                print(dataStr);
                baseList.setRange(index-1, index, [dataStr]);
                setState(() {

                });
                return;
              });
            },
          );
        }
    );
  }

  void serialPortTypeChanged(RegisterData registerData, int indexT) {
    var list = ['RS485-1', 'RS485-2'];


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
          String dataStr = DataTool.dataByteMessage(registerData, index.toString());
          serList.setRange(indexT, indexT+1, [dataStr]);
          setState(() {

          });
        });
  }

}
