
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
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/model/platform_parm_data.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/page/mqtt_page.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/page/obs_page.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlatformParmPage extends StatefulWidget {
  const PlatformParmPage({Key? key}) : super(key: key);

  @override
  State<PlatformParmPage> createState() => _PlatformParmPageState();
}

class _PlatformParmPageState extends State<PlatformParmPage> {

  late ThemeController themeController;
  late MonitorController monitorController;

  List allData = [];

  int paltIndex = Get.arguments['paltIndex'];

  String protocolType = '';
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
    String adLow = '';
    paltIndex == 1
        ? adLow = '08'
        : paltIndex == 2
        ? adLow = '14'
        : paltIndex == 3
        ? adLow = '20'
        : paltIndex == 4
        ? adLow = '2C'
        : adLow = '';
    String string = DataTool.sendGetMessageData('0A', adLow, 24);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('平台$paltIndex参数设置'),
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
                  if(monitorController.platformParmDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }

                  if (allData.length > 0) {
                    List<int> list = stringToDisplayIntList(allData.last);
                    List<int> newList1 = [];
                    if (list.length == 2) {
                      newList1.addAll([0, 0]);
                    }
                    newList1.addAll(list);
                    protocolType = ByteTool.codeToInt(newList1).toString();
                  } else {
                    List data = monitorController.platformParmDataList.last;
                    List<int> list = data.last;
                    List<int> newList1 = [];
                    if (list.length == 2) {
                      newList1.addAll([0, 0]);
                    }
                    newList1.addAll(list);
                    protocolType = ByteTool.codeToInt(newList1).toString();
                  }
                  for (int i = 0; i < monitorController.platformParmDataList.length; i ++) {
                    List data = monitorController.platformParmDataList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.platformParmDataList.length && monitorController.funcType == 3) {
                      allData.add(str);
                      
                    }
                  }

                  return ListView.builder(
                    itemCount: int.parse(protocolType) == 5
                        ? monitorController.platformParmDataList.length + 2
                        : monitorController.platformParmDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String content = '';
                      String title = '';
                      if (int.parse(protocolType) == 5 && index > monitorController.platformParmDataList.length -1) {
                        int moreIndex = index - (monitorController.platformParmDataList.length -1);
                        // print('moreIndex:$moreIndex');
                        moreIndex == 1 ? title = 'MQTT参数' : title = 'OBS参数';
                      } else {
                        List itemData = monitorController.platformParmDataList[index];
                        RegisterData registerData = itemData.first;
                        List<int> hexList = [];
                        if(allData.length > 0) {
                          String allIndex = allData[index];
                          hexList = stringToDisplayIntList(allIndex);
                        } else {
                          hexList = itemData.last;
                        }
                        title = registerData.content;
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
                          if (index == monitorController.platformParmDataList.length-1) {
                            content = platformParmType[int.parse(protocolType)] ?? '';
                          } else {
                            content = (value / registerData.multiple)
                                .toStringAsFixed(
                                registerData.multiple
                                    .toString()
                                    .length - 1) +
                                registerData.unit;
                          }
                        }
                      }


                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: title,
                          contentStr: content,
                        ),
                        onTap: () {
                          print(index);
                          if (int.parse(protocolType) == 5 && index > monitorController.platformParmDataList.length -1) {
                            int moreIndex = index - (monitorController.platformParmDataList.length -1);
                            if (moreIndex == 1) {
                              Get.to(()=>MQTTPage())!.then((value) => initData());
                            } else {
                              Get.to(()=>OBSPage())!.then((value) => initData());
                            }
                            return;
                          }
                          List itemData = monitorController.platformParmDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          if (index == monitorController.platformParmDataList.length - 1) {
                            platformParmTypeChanged(registerDataT, index);
                            return;
                          }
                          funcSendPlatformParmMonitor(registerDataT,index);

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
                  paltIndex == 1
                      ? adLow = '08'
                      : paltIndex == 2
                      ? adLow = '14'
                      : paltIndex == 3
                      ? adLow = '20'
                      : paltIndex == 4
                      ? adLow = '2C'
                      : adLow = '';
                  String headerStr = DataTool.sendWriteMessageMultipleData('0A', adLow, 24);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  // return;
                  allData = [];
                  monitorController.sendMessage(dataStr);
                },
                zhaocheFunction: (){
                  allData = [];
                  String adLow = '';
                  paltIndex == 1
                      ? adLow = '08'
                      : paltIndex == 2
                      ? adLow = '14'
                      : paltIndex == 3
                      ? adLow = '20'
                      : paltIndex == 4
                      ? adLow = '2C'
                      : adLow = '';
                  String string = DataTool.sendGetMessageData('0A', adLow, 24);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendPlatformParmMonitor(RegisterData registerData,int index) {
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
                  print(dataStr);
                  allData.setRange(index, index+1, [dataStr]);
                  setState(() {

                  });
                  return;
                } else {
                  String string = text.toString();
                  if (!registerData.isASCII) {
                    int textValue = ((double.parse(string) *registerData.multiple).truncate());
                    string = textValue.toString();
                  }
                  String valueStr = DataTool.dataByteMessage(registerData, string.toString());
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

  void platformParmTypeChanged(RegisterData registerData,int indexT) {
    // 0：无1：福建2：四川能投3：福建水雨晴4：雅安天全县
    // 5：广东6：江西7:贵州 8：湖南9：浙江丽水
    // 10：陕西泾阳县 11：安庆太湖县/潜山市
    var list = ['无', '福建','四川能投','福建水雨晴','雅安天全县','广东','江西7','贵州','湖南','浙江丽水','陕西泾阳县','安庆太湖县/潜山市'];

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
