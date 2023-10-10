import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class TextFieldWidget extends StatelessWidget {
  final Color color;
  final Color focusedColor;
  final String? hintText;
  final String screenText;
  final int minLines;
  final int maxLines;
  final TextEditingController? textController;
  final List<TextInputFormatter> input;
  const TextFieldWidget({
    Key? key,
    required this.color,
    required this.focusedColor,
    this.hintText,
    this.input = const <TextInputFormatter>[],
    this.minLines = 1,
    this.maxLines = 1,
    this.textController,
    this.screenText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      minLines: minLines,
      maxLines: maxLines,
      inputFormatters: input,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.inactiveBlack,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: AppTextStyle.subtitle.copyWith(
            color: AppColor.inactiveBlack,
          ),
          suffixIcon: (screenText.isNotEmpty)
              ? InkWell(
                  onTap: textController?.clear,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 20,
                      child: SvgPicture.asset(AppImages.clearTextField),
                    ),
                  ),
                )
              : null),
    );
  }
}
