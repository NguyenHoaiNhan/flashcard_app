import 'package:flashcard_app/config/app_colors.dart';
import 'package:flashcard_app/config/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(3, 6),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          label,
          style: AppStyles.h5.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}
