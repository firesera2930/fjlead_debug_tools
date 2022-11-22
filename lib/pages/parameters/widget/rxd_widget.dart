import 'package:flutter/material.dart';

class RxdWidget extends StatelessWidget {
  final Function? zhaocheFunction;
  final Function? xiafaFuncation;
  const RxdWidget({Key? key,this.zhaocheFunction, this.xiafaFuncation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Color(0xffeeeeee)),
                      // left: BorderSide(width: 1.0, color: Colors.red),
                      right: BorderSide(width: 1.0, color: Color(0xffeeeeee)),
                    )
                  ),
                  child: Center(
                    child: Text('召测',style: TextStyle(color: Colors.blue)),
                  ),
                ),
              onTap: ()=>this.zhaocheFunction!(),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xffeeeeee)),
                        left: BorderSide(width: 1.0, color: Color(0xffeeeeee)),
                        // right: BorderSide(width: 1.0, color: Colors.red),
                      )
                  ),
                  child: Center(
                    child: Text('下发',style: TextStyle(color: Colors.blue),),
                  ),
                ),
              onTap: ()=>this.xiafaFuncation!(),
            ),
          ),
        ],
      ),
    );
  }
}
