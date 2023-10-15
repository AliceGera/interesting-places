import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/info_card/widget/selection.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
import 'package:interesting_places/presentation/widget/app_button_widget.dart';

class InfoCardScreen extends StatefulWidget {
  static const routeName = '/infoCard';

  const InfoCardScreen({
    Key? key,
    required this.place,
  }) : super(key: key);
  final PlaceScreenData place;

  @override
  State<InfoCardScreen> createState() => _InfoCardScreenState();
}

class _InfoCardScreenState extends State<InfoCardScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.5,
              child: Stack(children: [
                PageView.builder(
                  itemCount: widget.place.photo.length,
                  itemBuilder: (context, position) {
                    return SizedBox(
                      height: size.height * 0.5,
                      width: double.infinity,
                      child: Image.memory(
                        widget.place.photo[position],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      AppImages.whiteBackArrow,
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Text(
                      widget.place.name,
                      style: AppTextStyle.title.copyWith(
                        color: AppColor.secondary,
                      ),
                    ),
                  ),
                  Text(
                    widget.place.category,
                    style: AppTextStyle.smallBold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      widget.place.description,
                      style: AppTextStyle.small,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: AppButtonWidget(
                      title: 'построить маршрут',
                      image: AppImages.go,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColor.inactiveBlack,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: SelectionWidget(
                      selectionPlan: 'Запланировать',
                      selectionFavorites: 'В Избранное',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
