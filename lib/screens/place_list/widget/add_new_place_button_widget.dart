import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_images.dart';
import 'package:interesting_places/utils/app_text_style.dart';

class AddNewPlaceButtonWidget extends StatelessWidget {
  const AddNewPlaceButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColor.green,
            AppColor.yellow,
          ],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.transparent.withOpacity(0.38),
          disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
          shadowColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppImages.plus),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "новое место".toUpperCase(),
                  style: AppTextStyle.smallBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
