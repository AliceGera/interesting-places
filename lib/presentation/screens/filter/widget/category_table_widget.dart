import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';

class CategoryTableWidget extends StatefulWidget {
  const CategoryTableWidget({
    super.key,
    required this.category,
    required this.callback,
    required this.isCheck,
  });

  final CategoryType category;
  final VoidCallback callback;
  final bool isCheck;

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
          Stack(
            alignment:AlignmentDirectional.bottomEnd,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: widget.callback,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: SvgPicture.asset(widget.category.getCategoryTypeImage()),
                ),
              ),
              if(widget.isCheck==true)
              SvgPicture.asset(AppImages.tickChoice),
            ],
          ),
          Text(
            widget.category.getCategoryTypeTitle(),
            style: AppTextStyle.superSmall,
          ),
        ],
      ),
    );
  }
}
