import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class PlaceWidget extends StatelessWidget {
  final PlaceScreenData places;

  const PlaceWidget({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          SizedBox(
            height: size.height * 0.25 / 2,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(places.photo.first),
                ),
              ),
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
                      places.category,
                      style: AppTextStyle.smallBold.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                    SvgPicture.asset(AppImages.whiteHeart),
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
                          places.name,
                          style: AppTextStyle.subtitle.copyWith(
                            color: AppColor.secondary,
                          ),
                        ),
                        Text(
                          places.description,
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
