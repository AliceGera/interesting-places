import 'package:flutter/material.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';

class AppBarMapWidget extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback clickCallback;

  const AppBarMapWidget({
    super.key,
    required this.clickCallback,
  });

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
            child: Text(
              'Отмена',
              style: AppTextStyle.subtitle.copyWith(
                color: AppColor.secondary2,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Text(
            'Местоположение',
            style: AppTextStyle.subtitle.copyWith(
              color: AppColor.main,
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: clickCallback,
            child: Text(
              'Готово',
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
