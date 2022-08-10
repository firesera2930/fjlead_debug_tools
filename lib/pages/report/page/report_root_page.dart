import 'package:debug_tools_wifi/components/event_bird.dart';
import 'package:debug_tools_wifi/pages/mine/page/mine_page.dart';
import 'package:debug_tools_wifi/pages/monitor/page/monitor_page.dart';
import 'package:debug_tools_wifi/pages/report/page/report_page.dart';
import 'package:debug_tools_wifi/pages/workbench/page/workbench_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// 导航区
class ReportRootPage extends StatefulWidget {
  @override
  _ReportRootPageState createState() => _ReportRootPageState();
}

class _ReportRootPageState extends State<ReportRootPage> with TickerProviderStateMixin {
  
  int _currentIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    loadPages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadPages(){
    pages = [
      /// 工作台
      MonitorPage(),
      /// 我的
      ReportPage()
    ];
  }
  

  

  @override
  Widget build(BuildContext context) {

    final themeController = Get.find<ThemeController>();
    
    return  MediaQuery(
      ///不受系统字体缩放影响
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pages
        ),
        bottomNavigationBar: Obx(() {
          ColorScheme colorScheme = themeController.colorScheme.value;
          return BottomNavigationBar(
            unselectedFontSize: 10,
            selectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorScheme.secondary,
            selectedItemColor: colorScheme.onSecondary,
            unselectedItemColor: colorScheme.onSecondary.withOpacity(0.7),
            items: [
              BottomNavigationBarItem(
                label: '数据调试',
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: _currentIndex == 0 ?  
                  Icon(Icons.router) :
                  Icon(Icons.router_outlined)
                ),
              ),

              BottomNavigationBarItem(
                label: '报文记录',
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: _currentIndex == 1 ?  
                  Icon(Icons.insert_comment):
                  Icon(Icons.insert_comment_outlined)
                ),
              ),

            ],
            currentIndex: _currentIndex,
            onTap: (int i) {
              
              _currentIndex = i;
              eventBird.emit('freshReport');
              setState(() {});
            },
          );
        }
      ))
    );
  }
}
