import 'package:flutter/material.dart';
import 'package:wordle/shared/extensions/media_query_extension.dart';
import 'package:wordle/shared/extensions/string_extension.dart';
import 'package:wordle/themes/app_text_style.dart';

class GameHistory extends StatelessWidget{
  const GameHistory({super.key, required this.userAnswer, required this.realAnswer});
  final String userAnswer;
  final String realAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _answerHistoryList(),
    );
  }

  List<Widget> _answerHistoryList() {
    List<Widget> widgets = <Widget>[];

    for (int index = 0; index < userAnswer.length; index++){
      widgets.add(
        _answerHistoryItem(index)
      );
    }

    return widgets;
  }

  Widget _answerHistoryItem(int index){
    return Container(
      margin: EdgeInsets.only(right: 1.w, left: 1.w, bottom: 1.h),
      child: Container(
        width: 14.w,
        height: 6.h,
        decoration: BoxDecoration(
            border: Border.all(color: userAnswer[index].borderColor),
            borderRadius: BorderRadius.circular(10),
            color: userAnswer[index].containerColor(index: index, realAnswer: realAnswer)
        ),
        child: Center(
          child: Text(
            userAnswer[index],
            style: AppTypography.heading7.copyWith(color: userAnswer[index].textColor),
          ),
        ),
      ),
    );
  }
}