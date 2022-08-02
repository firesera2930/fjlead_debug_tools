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

