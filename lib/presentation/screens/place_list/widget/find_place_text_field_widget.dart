import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/filter/filter_screen.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';

class FindPlaceTextFieldWidget extends StatelessWidget {
  final List<PlaceScreenData> places;

  FindPlaceTextFieldWidget({
    Key? key,
    required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Поиск',
        filled: true,
        fillColor: AppColor.background,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.background,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.background,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        suffixIcon: IconButton(
          icon: SvgPicture.asset(AppImages.settingsGreen),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>  FilterScreen(places:places),
              ),
            );
          },
        ),
        prefixIcon: IconButton(
          icon: SvgPicture.asset(AppImages.search),
          onPressed: () {},
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColor.background),
        ),
      ),
    );
  }
}
