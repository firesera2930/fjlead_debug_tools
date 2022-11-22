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
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterStationPage extends StatefulWidget {
  const MasterStationPage({Key? key}) : super(key: key);

  @override
  State<MasterStationPage> createState() => _MasterStationPageState();
}

class _MasterStationPageState extends State<MasterStationPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

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
    String string = DataTool.sendGetMessageData('09', '00', 50);
    monitorController.sendMessage(string);
  }
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('设备信息'),
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
                  if(monitorController.masterStationDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  for (int i = 0; i < monitorController.masterStationDataList.length; i ++) {
                    List data = monitorController.masterStationDataList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.masterStationDataList.length && monitorController.funcType == 3) {
                      allData.add(str);
                    }
                  }
                  return ListView.builder(
                    itemCount: monitorController.masterStationDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String content = '';
                      List itemData = monitorController.masterStationDataList[index];
                      RegisterData registerData = itemData.first;
                      List<int> hexList = [];
                      if(allData.length > 0) {
                        String allIndex = allData[index];
                        hexList = stringToDisplayIntList(allIndex);
                      } else {
                        hexList = itemData.last;
                      }
                      print('hexList:$hexList');
                      if (registerData.isIpAddress) {
                        print(hexList);
                        hexList.forEach((element) {
                          content.length == 0 ? content = element.toString() : content = content+"."+element.toString();
                        });
                      } else if (registerData.isASCII) {
                        content = MonitorData().getCharCodes(hexList).toString().trim();
                      } else {
                        List<int> newList = [];
                        if (hexList.length == 2) {
                          newList.addAll([0, 0]);
                        }
                        newList.addAll(hexList);
                        int value = ByteTool.codeToInt(newList);
                        content = (value / registerData.multiple)
                            .toStringAsFixed(
                            registerData.multiple
                                .toString()
                                .length - 1) +
                            registerData.unit;
                      }

                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: registerData.content,
                          contentStr: content,
                        ),
                        onTap: () {
                          List itemData = monitorController.masterStationDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          funcSendMasterStationMonitor(registerDataT, index);

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
                  allData.removeLast();
                  allData.removeLast();
                  allData.forEach((element) {
                    message.length == 0 ? message = element : message = message +' ' + element;
                  });
                  print('message:$message');
                  String headerStr = DataTool.sendWriteMessageMultipleData('09', '00', 18);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  allData = [];
                  monitorController.sendMessage(dataStr);
                },
                zhaocheFunction: () {
                  allData = [];
                  String string = DataTool.sendGetMessageData('09', '00', 50);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendMasterStationMonitor(RegisterData registerData, int index) {
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
                if(!registerData.isMinus && int.parse(text) < 0 ) {
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
                } else {
                  // String dataStr = DataTool.sendWriteMessageData(registerData, text);
                  String dataStr = DataTool.dataByteMessage(registerData, text);
                  allData.setRange(index, index+1, [dataStr]);
                  setState(() {

                  });
                }


              });
            },
          );
        }
    );
  }
}
