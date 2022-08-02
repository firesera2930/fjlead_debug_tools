import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:debug_tools_wifi/pages/monitor/page/monitor_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';


/// 工作台
class WorkbenchPage extends StatefulWidget {
  const WorkbenchPage({Key? key}) : super(key: key);

  @override
  State<WorkbenchPage> createState() => _WorkbenchPageState();
}

class _WorkbenchPageState extends State<WorkbenchPage> {
  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            
            headerWidget(),
            
            Expanded(
              child: ListView(
                children: [
                  functionItem(
                    icon: Icon(Icons.data_thresholding, size: 36),
                    text: '实时监测数据',
                    nextPage: Container()
                  )
                ],
              )
            ), 
          ],
        ) 
      ),
    );
  }

  /// 工作台页面头部
  Widget headerWidget() {
    return Container(
      height: 160,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 10),
            Text('工作台',style: TextStyle(color: Colors.white,fontSize: 32),),
            Container(height: 10),
            Divider(height: 1, color: Colors.white70,),
            Container(height: 10),
          ],
        ),
      ),
    );
  }

  /// 功能项
  Widget functionItem({
    required Icon icon,
    required String text,
    required Widget nextPage }){
      
    return InkWell(
      onTap: (){
        Get.to(() => MonitorPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 60,
                child: icon
              ),
              Center(
                child: Text(text, style: TextStyle(fontSize: 16),),
              ),
            ],
          ),
        ),
      )
    );
  }
}