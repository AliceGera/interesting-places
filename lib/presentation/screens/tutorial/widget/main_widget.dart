import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
    required this.size,
    required this.assetName,
    required this.title,
    required this.subtitle,
  });

  final Size size;
  final String assetName;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.23),
          SizedBox(
            height: size.height * 0.14,
            child: SvgPicture.asset(assetName),
          ),
          SizedBox(height: size.height * 0.05),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.title.copyWith(
              color: AppColor.main,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyle.small.copyWith(
              color: AppColor.secondary2,
            ),
          ),
        ],
      ),
    );
  }
}
