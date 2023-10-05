import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/screens/add_new_place/bloc/add_new_place_bloc.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_images.dart';
import 'package:interesting_places/utils/app_text_style.dart';
import 'package:interesting_places/widget/app_button_widget.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.categoryList,
    required this.bloc,
    required this.index,
  });

  final List<String> categoryList;
  final AddNewPlaceBloc bloc;
  final int index;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late int index;

  @override
  void initState() {
    index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.main,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          backgroundColor: AppColor.white,
          titleSpacing: 0.0,
          centerTitle: true,
          title: Text(
            'Категория',
            style: AppTextStyle.title.copyWith(
              color: AppColor.main,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: widget.categoryList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              index = i;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: SizedBox(
                              height: 24,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.categoryList[i],
                                    style: AppTextStyle.subtitle.copyWith(
                                      color: AppColor.main,
                                    ),
                                  ),
                                  if (index == i) SvgPicture.asset(AppImages.tick),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.1,
                          color: AppColor.inactiveBlack,
                        )
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AppButtonWidget(
                  title: 'сохранить',
                  index: index,
                  onPressed: () {
                    widget.bloc.add(AddCategoryForNewPlaceEvent(widget.categoryList[index]));
                    widget.bloc.add(SaveIndexForNewPlaceEvent(index));
                    Navigator.pop(context);
                  },
                  isEnable: index != -1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
