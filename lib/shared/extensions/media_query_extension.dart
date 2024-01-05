import 'package:flutter/material.dart';
import 'package:wordle/main.dart';

extension CustomMediaQuery on num {
  // double get h => MediaQueryData.fromView(WidgetsBinding.instance.window).size.height * this / 100;
  // double get w => MediaQueryData.fromView(WidgetsBinding.instance.window).size.width * this / 100;

  double get h => MediaQuery.of(navigatorKey.currentContext!).size.height * this / 100;
  double get w => MediaQuery.of(navigatorKey.currentContext!).size.width * this / 100;
}