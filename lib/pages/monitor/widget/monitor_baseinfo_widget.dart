import 'package:debug_tools_wifi/components/byte_tool.dart';
import 'package:debug_tools_wifi/model/monitor_data.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MonitorBaseInfoWidget extends StatelessWidget {
  const MonitorBaseInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<MonitorController>();

    return GetBuilder<MonitorController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('终端软件版本号', style: TextStyle(fontSize: 16)),
                    Text(controller.version.value, style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('监测点数量', style: TextStyle(fontSize: 16)),
                    Text('${controller.monitorNum.value}', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('核定流量', style: TextStyle(fontSize: 16)),
                    Text('${controller.verificationFlow.toStringAsFixed(4)} m³/s', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('瞬时总流量', style: TextStyle(fontSize: 16)),
                    Text('${controller.totalFlow.toStringAsFixed(4)} m³/s', style: TextStyle(fontSize: 16)),
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