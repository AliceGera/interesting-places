import 'package:flutter/material.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';

import 'custom_map_widget.dart';

class PointToMapWidget extends StatelessWidget {
  const PointToMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomMap(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 37,
        ),
        child: Text(
          'Указать на карте',
          style: AppTextStyle.subtitle.copyWith(
            color: AppColor.green,
          ),
        ),
      ),
    );
  }
}
