
class CommonUtils {
  // 判断是否为全数字
  // 1、(r'^-?[0-9.]+');是否含有数字。
  // 2、(r'^-?[0-9]+');是否全是数字。(r'^-?[0-9.]+');是否是数字和 . 的集合。
  // 3、(r'^[\u4e00-\u9fa5]+');是否含有汉字。
  // 4、(r'^[\u4e00-\u9fa5]+$');是否全是汉字。

  static bool stirngIsNumber(String string) {
    final reg = RegExp(r'^-?[0-9.]+$');
    return reg.hasMatch(string);
  }
}