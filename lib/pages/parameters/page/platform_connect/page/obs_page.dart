import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/pages/monitor/model/monitor_data.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OBSPage extends StatefulWidget {
  const OBSPage({Key? key}) : super(key: key);

  @override
  State<OBSPage> createState() => _OBSPageState();
}

class _OBSPageState extends State<OBSPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  Map allMap = {};

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
    String string = DataTool.sendGetMessageData('0C', '00', 128);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('OBS参数'),
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
                  if(monitorController.obsDataList.length == 0) {
                    return DefaultNoDataViewWidget();
                  }
                  return ListView.builder(
                    itemCount: monitorController.obsDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      List itemData = monitorController.obsDataList[index];
                      RegisterData registerData = itemData.first;
                      List<int> hexList = itemData.last;
                      String content = MonitorData().getCharCodes(hexList).toString();
                      /// 去除多余的空格符
                      content = content.trim();
                      if (allMap.length > 0) {
                        int indexM = allMap['index'];
                        String valueM = allMap['value'];
                        if (indexM == index) {
                          content = valueM;
                        }
                      }
                      return InkWell(
                        child: CustomRowListile(
                          rowType: RowType.defaultHRow,
                          titleName:registerData.content,
                          contentStr: content,
                        ),
                        onTap: () {
                          List itemData = monitorController.obsDataList[index];
                          RegisterData registerData = itemData.first;
                          funcSendObsMonitor(registerData,index);
                        },
                      );
                    },
                  );
                }),
              ),
              RxdWidget(
                xiafaFuncation: (){
                  if (allMap.length == 0) {
                    progressShowFail(context, '请先做出修改，在操作');
                    return;
                  }
                  int indexM = allMap['index'];
                  String valueM = allMap['value'];
                  List itemData = monitorController.obsDataList[indexM];
                  RegisterData registerData = itemData.first;
                  String dataStr = DataTool.sendWriteMessageData(registerData, valueM);
                  monitorController.sendMessage(dataStr);
                  allMap.clear();
                },
                zhaocheFunction: (){
                  allMap.clear();
                  String string = DataTool.sendGetMessageData('0C', '00', 128);
                  monitorController.sendMessage(string);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void funcSendObsMonitor(RegisterData registerData, int index) {
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogTextFieldWidget(
            title: registerData.content,
            content: '',
            tfHodText: '请输入${registerData.content}',
            cancelText: '取消',
            confirmText: '确定',
            cancelFun: () {
            },
            confirmFun: (text) async{
              if (!(text.toString().length >= registerData.minValue && text.toString().length <= registerData.maxValue)) {
                progressShowFail(context, registerData.defaultString);
                return;
              }
              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                allMap.clear();
                print(text);
                allMap.addAll({'index':index,'value':text.toString()});
                setState(() {
                });


              });
            },
          );
        }
    );
  }
}
