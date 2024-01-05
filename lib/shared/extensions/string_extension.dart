import 'package:flutter/material.dart';
import 'package:wordle/main.dart';
import 'package:wordle/shared/extensions/styles_extension.dart';
import 'package:english_words/english_words.dart';

extension StringExtension on String {
  String get selection => isEmpty ? "     " : this;

  Color get textColor => this == " " ? Colors.black : Colors.white;

  Color get borderColor => this == " " ? Colors.black : Colors.transparent;

  Color containerColor({required int index, required String realAnswer}){
    final appColors = navigatorKey.currentContext!.appColors;

    if (this == " ") {
      return appColors.background;
    } else {
      if (realAnswer.contains(this)){
        if (realAnswer[index] == this) {
          return Colors.green;
        } else {
          return Colors.yellow;
        }
      } else {
        return Colors.grey;
      }
    }
  }

  bool get isValidEnglish => all.contains(toLowerCase());
}