import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String title;
  final bool isEnable;
  final void Function()? onPressed;

  const AppButtonWidget({
    Key? key,
    required this.title,
    this.isEnable = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(isEnable ? const Color(0xFF4CAF50) : const Color(0xFFF5F5F5)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              height: 1.28,
              fontWeight: FontWeight.w700,
              color: isEnable ? Colors.white : const Color(0x8F7C7E92),
            ),
          ),
        ),
      ),
    );
  }
}
