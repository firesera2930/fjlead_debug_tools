import 'package:debug_tools_wifi/components/data_tool.dart';
import 'package:debug_tools_wifi/pages/monitor/controller/monitor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MonitorStateWidget extends StatelessWidget {
  const MonitorStateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Get.find<MonitorController>();
    
    return GetBuilder<MonitorController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            height: 90,
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
                    Text('连接状态', style: TextStyle(fontSize: 18)),
                    Container(
                      height: 20,
                      width: 50,
                      decoration:  BoxDecoration(
                        color: controller.socketConnect.isConnect ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ],
                ),
                Divider(height: 1, color: Colors.white30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // controller.sendMessage('00 00 00 00 00 06 68 03 00 00 00 56');
                        String string1 = DataTool.sendGetMessageData('00', '00', 208);
                        print(string1);
                        controller.sendMessage(string1);
                      },
                      child: Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text('召测数据', style: TextStyle(fontSize: 16))
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.onInitConnect();
                      },
                      child: Container(
                        height: 32,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text('重新连接', style: TextStyle(fontSize: 16))
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}