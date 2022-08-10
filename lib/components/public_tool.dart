import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bmprogresshud/bmprogresshud.dart';


/// 进度条 loading
void progressShowLoading(BuildContext context, String msg) {
  ProgressHud.of(context)?.show(ProgressHudType.loading, msg);
}

/// 进度条 success
void progressShowSuccess(BuildContext context, String msg) {
  ProgressHud.of(context)?.showAndDismiss(ProgressHudType.success, msg);
}

/// 进度条 fail
void progressShowFail(BuildContext context, String msg) {
  ProgressHud.of(context)?.showAndDismiss(ProgressHudType.error, msg);
}

/// 进度条 dismiss
void progressDismiss(BuildContext context) {
  ProgressHud.of(context)?.dismiss();
}

/// 双向选择框
showAlertViewDouble(BuildContext context, String title, String content,Function? ontap) {
  showCupertinoModalPopup<int>(
    context: context,
    builder: (t) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('确定'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(t).pop();
              if(ontap != null)ontap();
            },
          ),
          CupertinoDialogAction(
            child: Text('取消'),
            isDestructiveAction: true,
            onPressed: () {
              Navigator.of(t).pop();
            },
          ),
        ],
      );
    }
  );
}
