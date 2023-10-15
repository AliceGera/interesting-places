import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/screens/add_new_place/widget/text_field_widget.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_formatter.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
class LatitudeAndLongitudeWidget extends StatelessWidget {
  const LatitudeAndLongitudeWidget({
    super.key,
    required this.textLongitudeController,
    required this.longitude,
    required this.textLatitudeController,
    required this.latitude,
  });

  final TextEditingController textLongitudeController;
  final String longitude;
  final TextEditingController textLatitudeController;
  final String latitude;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'широта',
                  style: AppTextStyle.superSmall.copyWith(
                    color: AppColor.inactiveBlack,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: TextFieldWidget(
                  textController: textLatitudeController,
                  screenText: latitude,
                  color: AppColor.inactiveBlack.withOpacity(0.4),
                  focusedColor: AppColor.green.withOpacity(0.4),
                  input: [AppFormatter.longitudeOrLatitudeFormatter],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'долгота',
                  style: AppTextStyle.superSmall.copyWith(
                    color: AppColor.inactiveBlack,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: TextFieldWidget(
                  textController: textLongitudeController,
                  screenText: longitude,
                  color: AppColor.inactiveBlack.withOpacity(0.4),
                  focusedColor: AppColor.green.withOpacity(0.4),
                  input: [AppFormatter.longitudeOrLatitudeFormatter],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
