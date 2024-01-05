import 'package:flutter/material.dart';

class FinishDialog extends StatelessWidget{
  const FinishDialog({super.key, required this.alertTitle, required this.alertMessage, required this.onTap});
  final String alertTitle;
  final String alertMessage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(alertTitle),
      content: Text(alertMessage),
      actions: <Widget>[
        TextButton(
          onPressed: onTap,
          child: const Text('Try Again'),
        ),
      ],
    );
  }
}