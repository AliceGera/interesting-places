import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColor.white,
        ),
        child: Center(
          child: CircularProgressIndicator(color: AppColor.green),
        ),
      ),
    );
  }
}
