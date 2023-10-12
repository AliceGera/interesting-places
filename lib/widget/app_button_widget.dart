import 'package:flutter/material.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final bool isEnable;
  final VoidCallback? onPressed;
  final int? index;
  const AppButtonWidget({
    Key? key,
    required this.title,
    this.isEnable = true,
    this.onPressed,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isEnable ? AppColor.green : AppColor.background,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyle.button.copyWith(
              color: isEnable ? AppColor.white : AppColor.inactiveBlack,
            ),
          ),
        ),
      ),
    );
  }
}
