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

class GeneratorPowerPage extends StatefulWidget {
  const GeneratorPowerPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPowerPage> createState() => _GenetatorPowerPageState();
}

class _GenetatorPowerPageState extends State<GeneratorPowerPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  int powerIndex = Get.arguments['powerIndex'];

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
    String string = DataTool.sendGetMessageData('1$powerIndex', '00', 132);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('功率测量$powerIndex设置'),
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
                  if(monitorController.generatorPowerDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  for (int i = 0; i < monitorController.generatorPowerDataList.length; i++) {
                    List data = monitorController.generatorPowerDataList[i];
                    RegisterData registerData = data.first;
                    List<int> list = data.last;
                    String str = intListToDisplayString(list);
                    if(allData.length  < monitorController.generatorPowerDataList.length && monitorController.funcType == 3 && !registerData.isOnlyRead) {
                      allData.add(str);
                    }
                  }
                  return ListView.builder(
                    itemCount: monitorController.generatorPowerDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List itemData = monitorController.generatorPowerDataList[index];
                      RegisterData registerData = itemData.first;
                      // List<int> hexList = itemData.last;
                      List<int> hexList = [];
                      if(allData.length > 0 ) {
                        String allIndex = allData[index];
                        hexList = stringToDisplayIntList(allIndex);
                      } else {
                        hexList = itemData.last;
                      }
                      String content='';
                      if (registerData.isIpAddress) {
                        hexList.forEach((element) {
                          content.length == 0 ? content = element.toString() : content = content+"."+element.toString();
                        });
                      } else {
                        content = (ByteTool.codeToInt(hexList)/registerData.multiple).toStringAsFixed(
                            registerData.multiple
                                .toString()
                                .length - 1)+registerData.unit;
                      }
                      return InkWell(
                        child: registerData.content == '备用' ? CustomRowListile(rowType: RowType.nodataRow,) : CustomRowListile(
                          rowType: RowType.defaultLDRow,
                          titleName: registerData.content,
                          contentStr: content,
                        ),
                        onTap: () {
                          print(index);
                          List itemData = monitorController.generatorPowerDataList[index];
                          RegisterData registerDataT = itemData.first;
                          if (registerDataT.isOnlyRead) return;
                          String hight = registerDataT.addressHigh;
                          hight = '1$powerIndex';
                          registerDataT.addressHigh = hight;
                          funcSendPowerMonitor(registerDataT, index);
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
                  String headerStr = DataTool.sendWriteMessageMultipleData('1$powerIndex', '00', 132);
                  print(headerStr);
                  String dataStr = headerStr+message;
                  print('dataStr:$dataStr');
                  allData = [];
                  monitorController.sendMessage(dataStr);
                },
                zhaocheFunction: (){
                  allData = [];
                  String string = DataTool.sendGetMessageData('1$powerIndex', '00', 132);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendPowerMonitor(RegisterData registerData, int index) {
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
                string = textValue.toString();
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

  /// 重新排序
  void reList(){

  }
}
