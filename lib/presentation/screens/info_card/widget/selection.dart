import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class SelectionWidget extends StatelessWidget {
  final String selectionPlan;
  final String selectionFavorites;
  SelectionWidget({
    Key? key,
    required this.selectionPlan,
    required this.selectionFavorites
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(AppImages.calendar),
            ),
            Text(
              selectionPlan,
              style: AppTextStyle.small.copyWith(
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SvgPicture.asset(AppImages.heartFull),
            ),
            Text(
              selectionFavorites,
              style: AppTextStyle.small.copyWith(
                color: AppColor.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
