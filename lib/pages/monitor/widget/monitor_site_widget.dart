import 'package:debug_tools_wifi/model/register.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MonitorSiteWidget extends StatelessWidget {

  final List<RegisterData> registerDataList;

  const MonitorSiteWidget({required this.registerDataList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.find<MonitorController>();

    return GetBuilder<MonitorController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('text', style: TextStyle(fontSize: 18),),
                Divider(height: 1, color: Colors.white30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('类型:', style: TextStyle(fontSize: 16),),
                    Text('泄洪闸', style: TextStyle(fontSize: 16),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('瞬时流量:', style: TextStyle(fontSize: 16),),
                    Text('0.1000 m³/s', style: TextStyle(fontSize: 16),),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}