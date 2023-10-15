import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class AppBarFilterWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarFilterWidget({
    super.key,
    required this.clickCallback,
  });

  final VoidCallback clickCallback;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppImages.arrow),
          ),
          InkWell(
            onTap: () {
              clickCallback.call();
            },
            child: Text(
              'Очистить',
              style: AppTextStyle.subtitle.copyWith(
                color: AppColor.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
