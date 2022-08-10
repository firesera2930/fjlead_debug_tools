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
        /// 终端软件版本号
        String version = MonitorData().getCharCodes(controller.monitorData.value.tailData.first.value);
        /// 监测点数量
        int monitorNum = 0;
        /// 核定流量
        num verificationFlow = 0;
        /// 瞬时总流量
        num totalFlow = 0;

        controller.monitorData.value.basicData.forEach((element){
          if(element.content == '监测点数量'){
            monitorNum = ByteTool.messageToData(element.value);
          }else if(element.content == '核定流量'){
            verificationFlow = ByteTool.messageToData(element.value) / 10000;
          }else if(element.content == '瞬时总流量'){
            totalFlow = ByteTool.messageToData(element.value) / 10000;
          }
        });

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
                    Text(version, style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('监测点数量', style: TextStyle(fontSize: 16)),
                    Text('$monitorNum', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('核定流量', style: TextStyle(fontSize: 16)),
                    Text('${verificationFlow.toStringAsFixed(4)} m³/s', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('瞬时总流量', style: TextStyle(fontSize: 16)),
                    Text('${totalFlow.toStringAsFixed(4)} m³/s', style: TextStyle(fontSize: 16)),
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