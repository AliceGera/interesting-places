import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_images.dart';
import 'package:interesting_places/utils/app_text_style.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/paris.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'музей',
                      style: AppTextStyle.smallBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    SvgPicture.asset(AppImages.white_heart),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: size.height * 0.25 / 2,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColor.background,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Воронежский областной краеведческий музей',
                          style: AppTextStyle.subtitle.copyWith(
                            color: AppColor.secondary,
                          ),
                        ),
                        Text(
                          'краткое описание',
                          style: AppTextStyle.small.copyWith(
                            color: AppColor.secondary2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
