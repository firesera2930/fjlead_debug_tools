import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultNoDataViewWidget extends StatelessWidget {
  const DefaultNoDataViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
        // child: Text('暂无数据',style: TextStyle(color: Color(0xff666666),fontSize: 16),),
      ),
    );
  }
}
