import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_images.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColor.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.list_full),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.map),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.heart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.settings),
          label: '',
        ),
      ],
    );
  }
}
