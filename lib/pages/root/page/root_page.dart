import 'package:debug_tools_wifi/pages/mine/page/mine_page.dart';
import 'package:debug_tools_wifi/pages/workbench/page/workbench_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// 首页导航区
class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 
  List<Widget> pages = [
    /// 工作台
    WorkbenchPage(),
    /// 我的
    MinePage()
  ];

  

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
            unselectedFontSize: 13,
            selectedFontSize: 16,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorScheme.secondary,
            selectedItemColor: colorScheme.onSecondary,
            unselectedItemColor: colorScheme.onSecondary.withOpacity(0.7),
            items: [
              BottomNavigationBarItem(
                label: '工作台',
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: _currentIndex == 0 ?  
                  Icon(Icons.widgets) :
                  Icon(Icons.widgets_outlined)
                ),
              ),

              BottomNavigationBarItem(
                label: '我的',
                icon: SizedBox(
                  height: 24,
                  width: 24,
                  child: _currentIndex == 1 ?  
                  Icon(Icons.person):
                  Icon(Icons.person_outline)
                ),
              ),

            ],
            currentIndex: _currentIndex,
            onTap: (int i) {
              setState(() {
                _currentIndex = i;
              });
            },
          );
        }
      ))
    );
  }
}
