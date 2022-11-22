import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/components/socket/socket_connect.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/page/camera/page/camera_parm_page.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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
    String string = DataTool.sendGetMessageData('08', '00', 12);
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
                  if(monitorController.cameraDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }

                  for (int i = 0; i < monitorController.cameraDataList.length; i ++) {
                    List data = monitorController.cameraDataList[i];
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.cameraDataList.length && monitorController.funcType == 3) {
                      allData.add(str);
                    }

                  }
                  List cameraCountData = monitorController.cameraDataList[0];
                  List<int> chexList = cameraCountData.last;
                  List<int> countList = [];
                  if (chexList.length == 2) {
                    countList.addAll([0,0]);
                  }
                  countList.addAll(chexList);
                  int cNumCount = ByteTool.codeToInt(countList);
                  print('cNumCount:$cNumCount');
                  return ListView.builder(
                    itemCount: monitorController.cameraDataList.length+cNumCount,
                    itemBuilder: (BuildContext context, int index) {

                      String content = '';
                      String title = '';
                      if (index > monitorController.cameraDataList.length - 1) {
                        int count = index - monitorController.cameraDataList.length;
                        title = '${count+1}#摄像头参数';
                      } else {

                        List itemData = monitorController.cameraDataList[index];
                        RegisterData registerData = itemData.first;
                        List<int> hexList = [];
                        if(allData.length > 0) {
                          String dataStr = allData[index];
                          hexList = stringToDisplayIntList(dataStr);
                        } else {
                          hexList = itemData.last;
                        }

                        List<int> newList = [];
                        if (hexList.length == 2) {
                          newList.addAll([0,0]);
                        }
                        newList.addAll(hexList);
                        int value= ByteTool.codeToInt(newList);
                        if (index == 3) {
                          print('newList:$newList');
                          print(value);
                        }
                        content = (value / registerData.multiple)
                            .toStringAsFixed(
                            registerData.multiple.toString().length - 1) +
                            registerData.unit;
                        title = registerData.content;
                      }
                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: title,
                          contentStr: content,
                        ),
                        onTap: () {
                          print(index);
                          if (index > monitorController.cameraDataList.length - 1) {
                            int count = index - monitorController.cameraDataList.length;
                            Get.to(()=>CameraParmPage(),arguments: {'cameraIndex':count+1})!.then((value) => initData());
                            return;
                          }
                          List itemData = monitorController.cameraDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          funcSendCameraMonitor(registerDataT, index);

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
                  String headerStr = DataTool.sendWriteMessageMultipleData('08', '00', 12);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  monitorController.sendMessage(dataStr);
                  allData = [];
                },
                zhaocheFunction: (){
                  allData = [];
                  String string = DataTool.sendGetMessageData('08', '00', 12);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendCameraMonitor(RegisterData registerData, int index) {
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
                  progressShowFail(this.context, registerData.defaultString);
                  return;
                }

                if(!registerData.isMinus && int.parse(text) < 0) {
                  progressShowFail(this.context, '值不能为负数');
                  return;
                }
              }
              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                String valueStr = DataTool.dataByteToString(registerData.length, text.toString());
                print(valueStr);
                allData.setRange(index, index+1, [valueStr]);
                setState(() {

                });
                return;
              });
            },
          );
        }
    );
  }
}
