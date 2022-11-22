import 'package:debug_tools_wifi/components/public_tool.dart';
import 'package:flutter/material.dart';

class DialogTextFieldWidget extends Dialog {
  final String title; //标题
  final String content; //内容
  final String cancelText; //是否须要"取消"按钮
  final String confirmText; //是否须要"确定"按钮
  final Function cancelFun; //取消回调
  final Function confirmFun; //肯定回调
  final String tfHodText;

  TextEditingController _textS = TextEditingController();

  DialogTextFieldWidget(
      {Key? key,
        this.title = '提示',
        required this.content,
        this.cancelText = '取消',
        this.confirmText = '确定',
        this.tfHodText = '请输入',
        required this.cancelFun,
        required this.confirmFun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xffffffff),
                    height: 1.0,
                  ),
                  SizedBox(height: 30,),
                  Container(
                    constraints: BoxConstraints(minHeight: 50),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 12),
                      child: TextField(
                          controller: _textS,
                          style: TextStyle(color: Color(0xff666666)),
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              hintText: this.tfHodText,

                              hintStyle: TextStyle(fontSize: 13.0,color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                              // filled: true,
                              // fillColor: Color(0xffFFFFFF)
                          )),
                    ),
                  ),
                  Divider(height: 1,indent: 15,endIndent: 15,),
                  SizedBox(height: 30,),
                  Container(
                    color: Color(0xffeeeeee),
                    height: 1.0,
                  ),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '取消',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xffeeeeee),
                          height: 40.0,
                          width: 1,
                        ),
                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (_textS.text.isEmpty) {
                                  progressShowFail(context, '请输入相应内容');
                                  return;
                                }
                                this.confirmFun(_textS.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '确定',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldDialog extends Dialog {
  final Function onCancelEvent;
  final Function onSureEvent;
  final String tfHodText;
  final String nameString;

  TextFieldDialog(
      {Key? key,
      required this.onCancelEvent,
      required this.onSureEvent,
      this.tfHodText = '请输入',
      this.nameString = '提示'});

  TextEditingController _textS = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Stack(children: [
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text(this.nameString,
                                style: TextStyle(fontSize: 16.0)),
                            _textfieldWidget(),
                            Row(children: [
                              Expanded(child: _actionButtons(0)),
                              SizedBox(width: 15.0),
                              Expanded(child: _actionButtons(1))
                            ])
                          ]))))
            ])));
  }

  _textfieldWidget() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 25.0),
        child: TextField(
            controller: _textS,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                hintText: this.tfHodText,
                hintStyle: TextStyle(fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Color(0xFFf1efe5))));
  }

  _actionButtons(type) {
    return InkWell(
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: type == 0 ? Color(0xff999999) : Colors.blue,
                // border: Border.all(
                //     color: type == 0 ? Color(0xFF1E1E1E) : Colors.deepOrange
                // ),
                borderRadius: BorderRadius.circular(6.0)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                child: Text(type == 0 ? '取消' : '确认',
                    style: TextStyle(color: Colors.white, fontSize: 15.0)))),
        onTap: () {
          if (type == 0) {
            onCancelEvent();
          } else {
            if (_textS.text.isEmpty) {
              // ToastCommon.showToast('请输入电话号码');
              return;
            }
            onSureEvent(_textS.text);
          }
        });
  }
}
