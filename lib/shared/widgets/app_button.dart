import 'package:flutter/material.dart';
import 'package:wordle/shared/extensions/styles_extension.dart';
import 'package:wordle/themes/app_text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.transparent),
          ),
        ),
        child: Text(
          "SUBMIT",
          style: AppTypography.heading8.copyWith(color: colors.onPrimary, fontSize: 16),
        ),
      ),
    );
  }
}