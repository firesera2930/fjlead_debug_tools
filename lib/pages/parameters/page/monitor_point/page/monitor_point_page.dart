import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/common/default_view_widget.dart';
import 'package:debug_tools_wifi/common/textField_dialog_common.dart';
import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:debug_tools_wifi/pages/parameters/page/monitor_point/page/monitor_point_parmset_page.dart';
import 'package:debug_tools_wifi/pages/parameters/widget/rxd_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MonitorPointPage extends StatefulWidget {
  const MonitorPointPage({Key? key}) : super(key: key);

  @override
  State<MonitorPointPage> createState() => _MonitorPointPageState();
}

class _MonitorPointPageState extends State<MonitorPointPage> {
  late ThemeController themeController;
  late MonitorController monitorController;

  String _countStr = '';
  int countIndex = 0;

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
    String string = DataTool.sendGetMessageData('01', '0E', 8);
    monitorController.sendMessage(string);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('监测点参数'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: GetBuilder<MonitorController>(builder: (monitorController) {

                    int code = 0;
                    if(monitorController.registerPointData.length == 0) {
                      return DefaultNoDataViewWidget();
                    }
                    List<RegisterData> data = monitorController.registerPointData[0];
                    // 监测点个数
                    RegisterData regData = data.first;
                    if (_countStr.length == 0) {
                      countIndex = ByteTool.codeToInt(regData.value);
                    } else {
                      countIndex = int.parse(_countStr);
                    }
                    // 监测点类型
                    RegisterData regDataCode = data[1];
                    code = ByteTool.codeToInt(regDataCode.value);


                    return ListView.builder(
                      itemCount: countIndex + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: CustomRowListile(
                              rowType: RowType.moreRow,
                              titleName: index == 0 ? '监测点数量设置：$countIndex':'监测点$index参数设置'
                          ),
                          onTap: (){
                            if (index == 0) {
                              setPointCount(regData);
                            } else {
                              monitorController.monitorPointSetList = [];
                              Get.to(()=>MonitorPointParmSetPage(), arguments: {'type':code,'index':index});
                            }
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
      ),
    );
  }

  void setPointCount(RegisterData registerData) {
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DialogTextFieldWidget(
            title: '数量设置',
            content: '',
            tfHodText: registerData.defaultString,
            cancelText: '取消',
            confirmText: '确定',
            cancelFun: () {
            },
            confirmFun: (text) async{
              if (!(double.parse(text.toString()) >= registerData.minValue && double.parse(text.toString()) <= registerData.maxValue)) {
                progressShowFail(context, registerData.defaultString);
                return;
              }
              if(!registerData.isMinus && int.parse(text) < 0 && !registerData.isASCII && !registerData.isIpAddress) {
                progressShowFail(context, '值不能为负数');
                return;
              }
              Get.back();
              Future.delayed(Duration(milliseconds: 300), () {
                print("延时1秒执行");
                print(text);
                List<RegisterData> data = monitorController.registerPointData[0];
                RegisterData regData = data.first;
                String dataStr = DataTool.sendWriteMessageData(regData, text.toString());
                print(dataStr);
                _countStr = '';
                monitorController.sendMessage(dataStr);
              });
            },
          );
        }
    );
  }
}