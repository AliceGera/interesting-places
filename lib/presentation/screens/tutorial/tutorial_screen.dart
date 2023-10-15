import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interesting_places/presentation/screens/add_new_place/add_new_place_screen.dart';
import 'package:interesting_places/presentation/screens/tutorial/bloc/tutorial_bloc.dart';
import 'package:interesting_places/presentation/screens/tutorial/widget/app_bar_tutorial_widget.dart';
import 'package:interesting_places/presentation/screens/tutorial/widget/main_widget.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/widget/app_button_widget.dart';
import 'package:interesting_places/presentation/widget/indicator_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TutorialScreen extends StatefulWidget {
  static const routeName = '/tutorial';

  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController controller = PageController();
  var index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => TutorialBloc()..add(LoadTutorialEvent()),
      child: BlocBuilder<TutorialBloc, TutorialState>(
        builder: (context, state) {
          switch (state) {
            case TutorialLoadingState() || TutorialInitialState():
              return const CircularProgressIndicatorWidget();
            case TutorialFailedState():
              return const CircularProgressIndicatorWidget();
            case TutorialSuccessState():
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColor.white,
                  appBar: AppBarTutorialWidget(index: index),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.7,
                          child: PageView(
                            physics: const BouncingScrollPhysics(),
                            controller: controller,
                            onPageChanged: (idx) {
                              setState(() {
                                index = idx;
                              });
                            },
                            children: <Widget>[
                              MainWidget(
                                size: size,
                                assetName: AppImages.tutorial_1,
                                title: 'Добро пожаловать \nв Путеводитель',
                                subtitle: 'Ищи новые локации и сохраняй \nсамые любимые.',
                              ),
                              MainWidget(
                                size: size,
                                assetName: AppImages.tutorial_2,
                                title: 'Построй маршрут \nи отправляйся в путь',
                                subtitle: 'Достигай цели максимально \nбыстро и комфортно.',
                              ),
                              MainWidget(
                                size: size,
                                assetName: AppImages.tutorial_3,
                                title: 'Добавляй места,\nкоторые нашёл сам',
                                subtitle: 'Делись самыми интересными\nи помоги нам стать лучше!',
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          axisDirection: Axis.horizontal,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: AppColor.green,
                            dotWidth: 8,
                            dotHeight: 8,
                            dotColor: AppColor.inactiveBlack,
                          ),
                        ),
                        if (index == 2) ...[
                          SizedBox(height: size.height * 0.04),
                          AppButtonWidget(
                            title: 'на старт',
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPlaceScreen() /*PlaceListScreen()*/));
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                        ] else
                          SizedBox(height: size.height * 0.05 + 48),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
