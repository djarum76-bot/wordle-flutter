import 'package:flutter/material.dart';

extension FocusNodeExtension on List<FocusNode>{
  void removeFocus() {
    for (var focus in this) {
      focus.unfocus();
    }
  }
}