import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class CategoryTableWidget extends StatefulWidget {
  const CategoryTableWidget({
    super.key,
    required this.category,
  });

  final String category;
  @override
  State<CategoryTableWidget> createState() => _CategoryTableWidgetState();
}

class _CategoryTableWidgetState extends State<CategoryTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SvgPicture.asset(AppImages.hotel),
          ),
          Text(
            widget.category,
            style: AppTextStyle.superSmall,
          ),
        ],
      ),
    );
  }
}
