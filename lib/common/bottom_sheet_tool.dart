import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:ui';

///底部弹出选择器工具类
typedef StringClickCallback = void Function(int selectIndex, Object selectStr);
typedef ArrayClickCallback = void Function(
    List<int> selecteds, List<dynamic> strData);
typedef DateClickCallback = void Function(
    dynamic selectDateStr, dynamic selectDate);

class showBottomSheetTool {
  //选择器的高度
  double pickerHeight;
  //单行的高度
  double itemHeight;
  //按钮颜色
  Color btnColor;
  //按钮颜色
  Color cancelColor;
  //文本颜色
  Color titleColor;
  //字体大小
  double textFontSize;
  showBottomSheetTool(
      {this.pickerHeight = 200.0,
        this.itemHeight = 45.0,
        this.cancelColor = Colors.black26,
        this.btnColor = Colors.lightBlueAccent,
        this.titleColor = const Color.fromRGBO(127, 127, 127, 1.0),
        this.textFontSize = 16.0});

  ///单列
  void showSingleRowPicker<T>(
      BuildContext context, {
        required List<T> data,
        String? title,
        int? normalIndex,
        PickerDataAdapter? adapter,
        required StringClickCallback clickCallBack,
      }) {
    openPicker(context,
        adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: false),
        clickCallBack: (Picker picker, List<int> selecteds) {
          clickCallBack(selecteds[0], data[selecteds[0]].toString());
        }, selecteds: [normalIndex ?? 0], title: title);
  }

  ///多列
  void showArrayPicker<T>(
      BuildContext context, {
        required List<T> data,
        String title='',
        List<int>? normalIndex,
        PickerDataAdapter? adapter,
        required ArrayClickCallback clickCallBack,
      }) {
    openPicker(context,
        adapter: adapter ?? PickerDataAdapter(pickerdata: data, isArray: true),
        clickCallBack: (Picker picker, List<int> selecteds) {
          clickCallBack(selecteds, picker.getSelectedValues());
        }, selecteds: normalIndex!, title: title);
  }

  void openPicker(
      BuildContext context, {
        required PickerAdapter adapter,
        String? title,
        List<int>? selecteds,
        required PickerConfirmCallback clickCallBack,
      }) {
    new Picker(
      adapter: adapter,
      title: new Text(
        title ?? "请选择",
        style: TextStyle(
          color: this.titleColor,
          fontSize: this.textFontSize,
        ),
      ),
      selecteds: selecteds,
      confirmText: '确定',
      cancelText: '取消',
      cancelTextStyle: TextStyle(
        color: this.cancelColor,
        fontSize: this.textFontSize,
      ),
      confirmTextStyle: TextStyle(
        color: this.btnColor,
        fontSize: this.textFontSize,
      ),
      textAlign: TextAlign.right,
      itemExtent: this.itemHeight,
      height: this.pickerHeight,
      selectedTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 15
      ),
      textStyle: TextStyle(
        fontSize: 13,
        color: Colors.grey,
      ),
      onConfirm: clickCallBack,
    ).showModal(context);
  }
}