import 'package:flutter/material.dart';
import 'package:wordle/shared/extensions/media_query_extension.dart';

class GameTextField extends StatelessWidget{
  const GameTextField({super.key, required this.focusNodes, required this.controllers});
  final List<FocusNode> focusNodes;
  final List<TextEditingController> controllers;

  void _fieldFocusChanged(BuildContext context, int index) {
    if (index < controllers.length - 1) {
      if (controllers[index].text.isNotEmpty) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      // If the last OTP field is filled, unfocus the field
      if (controllers[index].text.isNotEmpty) {
        focusNodes[index].unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(controllers.length, (index) {
        return Container(
          margin: EdgeInsets.only(right: 1.w, left: 1.w),
          child: SizedBox(
            width: 14.w,
            height: 6.h,
            child: TextFormField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              textAlign: TextAlign.center,
              maxLength: 1,
              onChanged: (value) {
                _fieldFocusChanged(context, index);
              },
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        );
      },
      ),
    );
  }
}