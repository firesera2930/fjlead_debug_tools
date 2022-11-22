import 'package:debug_tools_wifi/common/number_formatter_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RowType {
  // 文+文 
  defaultRow,
  defaultLDRow,
  defaultHRow,
  // 文+文+ > 
  moreRow,
  // 文+输入框
  textFieldRow,
  // 文+输入框(数字)
  textFieldNumberRow,

  // 无数据
  nodataRow,
}

// （图+文）+图

class CustomRowListile extends StatelessWidget {
  final String titleName;
  final String contentStr;
  final Function? downFunction;
  final double height;
  final RowType rowType;
  final double spaceW;
  final String textFieldHold;
  final Color? contentTextColor;
  final Color? titleColor;
  final double titleFontSize;
  final TextEditingController? tfController;
  final Function? searchFunction;
  final Function? freshFunction;
  final TextInputAction? textInputAction;
  final bool enable;
  final FocusNode? focusNode;
  final FontWeight? titleWeight;
  final TextInputType keyBoardType;


  CustomRowListile(
      {Key? key,
      this.titleName = '',
      required this.rowType,
      this.contentStr = '',
      this.downFunction,
      this.height = 49.0,
      this.spaceW = 15.0,
      this.textFieldHold = '请输入',
      this.tfController,
      this.contentTextColor,
      this.searchFunction,
      this.freshFunction,
      this.textInputAction,
      this.enable = true,
      this.keyBoardType = TextInputType.text,
      this.titleColor,
      this.titleFontSize = 14,
      this.titleWeight,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(this.rowType == RowType.defaultRow) {
      // 文+文
      return Container(
        // height: height,
        constraints: BoxConstraints(minHeight: height),
        child: defalutRow(),
      );
    } else if(this.rowType == RowType.textFieldRow) {
      return Container(
        height: this.height,
        child: textFieldRow(),
      );
    } else if(this.rowType == RowType.textFieldNumberRow) {
      return Container(
        height: this.height,
        child: textFieldNumberRow(),
      );
    } else if(this.rowType == RowType.moreRow) {
      return moreListRow();
    } else if(this.rowType == RowType.defaultLDRow) {
      return defaultLDRow();
    } else if(this.rowType == RowType.defaultHRow) {
      return defaultHRow();
    } else if(this.rowType == RowType.nodataRow) {
      return nodataRow();
    }
    return Container();
  }

  FocusNode _inputFocusNode = FocusNode();

  Widget nodataRow () {
    return Container(height: 1,width: double.infinity,);
  }

  Widget defalutRow() {
    return Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: spaceW),
            child: Text(
              titleName,
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                color: titleColor ?? Color(0xff333333),
                fontSize: titleFontSize,
                fontWeight: titleWeight ?? null,
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: spaceW),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  contentStr,
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: contentTextColor ?? Color(0xff999999),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ]
    );
  }
  
  Widget moreListRow () {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Text(this.titleName, style: TextStyle(fontSize: 14),),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(this.contentStr, style: TextStyle(fontSize: 14),),
                        ),
                        Center(
                          child: Icon(Icons.chevron_right_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1,),
          ],
        )
    );
  }

  Widget defaultHRow () {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.only(top: 16,bottom: 16),
              child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      width: 100,
                      child: Text(
                        titleName,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          // color: titleColor ?? Color(0xff333333),
                          fontSize: titleFontSize,
                          fontWeight: titleWeight ?? null,
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            contentStr,
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              color: contentTextColor ?? Color(0xff666666),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Divider(height: 1,),
          ),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.only(top: 16,bottom: 16),
      child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                titleName,
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  // color: titleColor ?? Color(0xff333333),
                  fontSize: titleFontSize,
                  fontWeight: titleWeight ?? null,
                ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    contentStr,
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: contentTextColor ?? Color(0xff999999),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget defaultLDRow () {
    return Container(
        height: 50,
        padding: EdgeInsets.only(left: 15,right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(this.titleName, style: TextStyle(fontSize: 14),),
                  ),
                  Center(
                    child: Text(this.contentStr, style: TextStyle(fontSize: 14),),
                  ),
                ],
              ),
            ),
            Divider(height: 1,),
          ],
        )
    );
  }

  Widget textFieldRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: spaceW),
            child: Text(this.titleName,style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: titleColor ?? Color(0xff333333),
              fontSize: 14,
            ),),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(right: spaceW),
            child: TextField(
              textInputAction: this.textInputAction ?? TextInputAction.done,
              controller: tfController,

              enabled: enable,
              keyboardType: keyBoardType,
              style: TextStyle(fontSize: 14, color: Color(0xff333333)),
              textAlign: TextAlign.right,
              focusNode: this.focusNode ?? _inputFocusNode,
              onSubmitted: (value) => value != null
                  ? this.searchFunction!()
                  : print('没有输入'),
              decoration: InputDecoration(
                hintText: textFieldHold,
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff999999)),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldNumberRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: spaceW),
            child: Text(this.titleName,style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Color(0xff333333),
              fontSize: 14,
            ),),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(right: spaceW),
            child: TextField(
              textInputAction: this.textInputAction ?? TextInputAction.done,
              keyboardAppearance: Brightness.light,
              controller: tfController,
              enabled: enable,
              inputFormatters: [FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),NumberTextInputFormatterUtils(digit: 4)],
              keyboardType: keyBoardType,
              style: TextStyle(fontSize: 14, color: contentTextColor??Color(0xff333333)),
              textAlign: TextAlign.right,
              focusNode: focusNode,
              onSubmitted: (value) => value != null
                  ? this.searchFunction!()
                  : print('没有输入'),
              decoration: InputDecoration(
                hintText: textFieldHold,
                hintStyle: TextStyle(fontSize: 14, color: Color(0xff999999)),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

}