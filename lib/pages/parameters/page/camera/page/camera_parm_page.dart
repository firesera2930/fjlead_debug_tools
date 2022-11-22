
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
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraParmPage extends StatefulWidget {
  const CameraParmPage({Key? key}) : super(key: key);

  @override
  State<CameraParmPage> createState() => _CameraParmPageState();
}

class _CameraParmPageState extends State<CameraParmPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  int cameraIndex = Get.arguments['cameraIndex'];

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
    await Future.delayed(const Duration(milliseconds: 100));
    allData = [];
    String adLow = '';
    cameraIndex == 1
        ? adLow = '06'
        : cameraIndex == 2
            ? adLow = '1A'
            : cameraIndex == 3
                ? adLow = '2E'
                : cameraIndex == 4
                    ? adLow = '42'
                    : adLow = '';
    String string = DataTool.sendGetMessageData('08', adLow, 40);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('摄像头参数'),
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
                  if(monitorController.cameraParmDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  for (int i = 0; i < monitorController.cameraParmDataList.length; i ++) {
                    List data = monitorController.cameraParmDataList[i];
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.cameraParmDataList.length && monitorController.funcType == 3) {
                      allData.add(str);
                    }

                  }
                  return ListView.builder(
                    itemCount: monitorController.cameraParmDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String content = '';
                      List itemData = monitorController.cameraParmDataList[index];
                      RegisterData registerData = itemData.first;
                      List<int> hexList11 = itemData.last;
                      List<int> hexList = [];
                      if(allData.length > 0) {
                        String dataStr = allData[index];
                        hexList = stringToDisplayIntList(dataStr);
                      } else {
                        hexList = itemData.last;
                      }
                      // 是否是ASC
                      if (registerData.isASCII) {
                        content = MonitorData().getCharCodes(hexList).toString();
                        /// 去除多余的空格符
                        content = content.trim();
                      } else if (registerData.isIpAddress) {
                        // 是否是ip地址
                        hexList.forEach((element) {
                          content.length == 0 ? content = element.toString() : content = content+"."+element.toString();
                        });
                      } else {
                        List<int> newList = [];
                        if (hexList.length == 2) {
                          newList.addAll([0, 0]);
                        }
                        newList.addAll(hexList);
                        int value = ByteTool.codeToInt(newList);
                        if (index == 2) {
                          value == 0 ? content = '无' : value == 1 ? content = 'basic' : value == 2 ? content = 'digest' : content = '';
                        } else {
                          content = (value / registerData.multiple)
                              .toStringAsFixed(
                              registerData.multiple
                                  .toString()
                                  .length - 1) +
                              registerData.unit;
                        }
                      }

                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: registerData.content,
                          contentStr: content,
                        ),
                        onTap: () {
                          // print(index);
                          List itemData = monitorController.cameraParmDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          if (index == 2) {
                            cameraParmTypeChanged(registerDataT,index);
                            return;
                          }
                          funcSendCameraParmMonitor(index, registerDataT);

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
                  print('message:$message');
                  String adLow = '';
                  cameraIndex == 1
                      ? adLow = '06'
                      : cameraIndex == 2
                      ? adLow = '1A'
                      : cameraIndex == 3
                      ? adLow = '2E'
                      : cameraIndex == 4
                      ? adLow = '42'
                      : adLow = '';
                  String headerStr = DataTool.sendWriteMessageMultipleData('08', adLow, 40);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  allData = [];
                  monitorController.sendMessage(dataStr);

                },
                zhaocheFunction: () {
                  allData = [];
                  String adLow = '';
                  cameraIndex == 1
                      ? adLow = '06'
                      : cameraIndex == 2
                      ? adLow = '1A'
                      : cameraIndex == 3
                      ? adLow = '2E'
                      : cameraIndex == 4
                      ? adLow = '42'
                      : adLow = '';
                  String string = DataTool.sendGetMessageData('08', adLow, 40);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendCameraParmMonitor(int index,RegisterData registerData) {
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
                  if(!registerData.isMinus && int.parse(text) < 0 && !registerData.isASCII && !registerData.isIpAddress) {
                    progressShowFail(context, '值不能为负数');
                    return;
                  }
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
                  String dataStr1 = DataTool.sendWriteMessageListData(registerData, dataList);
                  // print(dataStr);
                  monitorController.sendMessage(dataStr);
                } else {
                  String valueStr = DataTool.dataByteMessage(registerData, text.toString());
                  allData.setRange(index, index+1, [valueStr]);
                  setState(() {

                  });
                  return;
                }
              });
            },
          );
        }
    );
  }

  void cameraParmTypeChanged(RegisterData registerData, int indexT) {

    var list = ['无', 'basic', 'digest'];

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
          allData.setRange(indexT, indexT+1, [dataStr]);
          setState(() {

          });
        });
  }
}
