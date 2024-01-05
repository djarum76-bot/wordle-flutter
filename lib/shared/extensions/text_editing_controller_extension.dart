import 'package:flutter/material.dart';

extension TextEditingValue on List<TextEditingController>{
  String get value {
    String otp = '';
    for (var controller in this) {
      otp += controller.text;
    }
    return otp;
  }

  void clearField() {
    for (var controller in this) {
      controller.clear();
    }
  }

  bool get isValid {
    for (var controller in this) {
      if (controller.text.isEmpty) {
        return false;
      }
    }

    return true;
  }
}