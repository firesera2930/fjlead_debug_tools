import 'package:debug_tools_wifi/components/event_bird.dart';
import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:debug_tools_wifi/cache/logs_cache.dart';
import 'package:debug_tools_wifi/model/logs_data.dart';
import 'package:debug_tools_wifi/pages/report/widget/report_list_widget.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReportPage extends StatefulWidget {

  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  late ThemeController themeController;
  late List<Tab> tabList = [];

  int currentTab = 0;
  List<LogsData> currentData = [];

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();

    tabList..add(
      tabHeader(
        icon: Icons.import_export,
        title: '所有报文'
      )
    )..add(
      tabHeader(
        icon: Icons.move_to_inbox,
        title: '收到报文'
      )
    )..add(
      tabHeader(
        icon: Icons.outbox,
        title: '发送报文'
      )
    );

    changeTab(currentTab);

    eventBird.on('freshReport', (_) { 
      changeTab(currentTab);
      setState(() {});
    });
  }

  @override
  void dispose() {
    eventBird.off('freshReport');
    super.dispose();
  }

  /// 改变Tab
  void changeTab(int value){
    currentTab = value;

    switch (value) {
      case 0:
        currentData = LogsCache.getInstance().logsList.toList();
        break;
      case 1:
        currentData = LogsCache.getInstance().receivedLogsList.toList();
        break;
      case 2:
        currentData = LogsCache.getInstance().sendLogsList.toList();
        break;
      default:
        currentData = LogsCache.getInstance().logsList.toList();
    }
    setState(() { });
  }
  
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('报文记录'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () => alert(),
              child: SizedBox(
                height: 24,
                width: 24,
                child: Icon(Icons.delete_sweep_outlined),
              ),
            ),
            
            Container(
              width: 10,
            )
          ]
        ),
        body: Column(
          children: [ 
            SizedBox(height: 20,),
            DefaultTabController(
              length: tabList.length,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: TabBar(
                      isScrollable: true,
                      tabs: tabList,
                      labelColor: Colors.white,
                      onTap: (value) {
                        changeTab(value);
                      },
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: ReportListWidget(
                logsDataList: currentData,
              ),
            ),
            Container(height: 20)
          ]
        )
      )
    );
  }

  /// tab头信息内容
  Tab tabHeader({
    required IconData icon,
    required String title}){
    return Tab(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Icon(icon,color: Colors.white,),
            ),
            Text(title, style: TextStyle(color: Colors.white,fontSize: 14)),
          ],
        )
      ),
    );
  }

  /// 弹出框
  void alert(){
    showAlertViewDouble(context, '提示', '是否清除全部报文记录', () async {
      await LogsCache.getInstance().delete();
      changeTab(currentTab);
      setState(() {});
    });
  }
  
}