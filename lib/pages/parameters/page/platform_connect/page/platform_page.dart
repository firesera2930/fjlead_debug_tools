import 'package:debug_tools_wifi/common/custom_row_listile.dart';
import 'package:debug_tools_wifi/pages/parameters/page/platform_connect/page/platform_parm_page.dart';
import 'package:debug_tools_wifi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlatformPage extends StatefulWidget {
  const PlatformPage({Key? key}) : super(key: key);

  @override
  State<PlatformPage> createState() => _PlatformPageState();
}

class _PlatformPageState extends State<PlatformPage> {
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('平台连接参数'),
          centerTitle: true,
          backgroundColor: themeController.colorScheme.value.inversePrimary,
          elevation: 0,
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context,int index) {
              return InkWell(
                child: CustomRowListile(
                  rowType: RowType.moreRow,
                  titleName: '平台${index+1}参数设置',
                ),
                onTap: (){
                  Get.to(()=>PlatformParmPage(),arguments: {'paltIndex':index+1});
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
