import 'package:flutter/material.dart';
import 'package:interesting_places/screens/add_new_place/add_new_place_screen.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';

class AppBarTutorialWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTutorialWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: index != 2
          ? InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 18, 16, 18),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddNewPlaceScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Пропустить',
                          style: AppTextStyle.subtitle.copyWith(
                            color: AppColor.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
