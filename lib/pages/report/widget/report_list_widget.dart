import 'package:date_format/date_format.dart';
import 'package:debug_tools_wifi/model/logs_data.dart';
import 'package:flutter/material.dart';


class ReportListWidget extends StatelessWidget {

  final List<LogsData> logsDataList;
  const ReportListWidget({required this.logsDataList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size; 
    double width = size.width; 
    List<LogsData> dataList = logsDataList.reversed.toList();

    return ListView.builder(
      reverse: true, 
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int i){
        return itemWidget(
          logsData: dataList[i],
          width: width
        );
      }
    );
  }

  Widget itemWidget({
    required LogsData logsData,
    required double width }){

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      width: width,
      child: Column(
        children: [
          logsData.time != null ? Text(formatDate(logsData.time!, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss] )) : Container(),
          Row(
            mainAxisAlignment: logsData.logType == LogType.send ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(),
              Container(
                width: width * 0.75,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: logsData.logType == LogType.send ? Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.arrow_upward, color: Colors.green,),
                          ),
                          Text('发送', style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(logsData.byteStr),
                    ),
                  ],
                ) : Row(
                  children: [
                    Expanded(
                      child: Text(logsData.byteStr),
                    ),
                    Container(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Icon(Icons.arrow_downward, color: Colors.orange),
                          ),
                          Text('收到', style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  ],
                )
              ),
              Container(),
            ],
          ),
        ],
      )
    );
  }
}