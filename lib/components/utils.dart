import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class UtilFs {
  static showToast(String message, Color backgroundColor, BuildContext context) {
    ToastContext().init(context);
    Toast.show(message, duration: Toast.lengthShort, gravity: Toast.center, backgroundColor: backgroundColor);
  }

  static showErrorToast(String message, BuildContext context) {
    showToast(message, Color(0xFF1B5E20), context);
  }

  static showSuccessToast(String message, BuildContext context) {
    showToast(message, Color(0xFFE8F5E9), context);
  }
}
