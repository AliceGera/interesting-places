import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/screens/add_new_place/add_new_place_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widget/app_button_widget.dart';
import 'bloc/tutorial_bloc.dart';

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
          if (state is TutorialLoadingState || state is TutorialInitialState) {
            return Container();
          } else if (state is TutorialFailedState) {
            return Container();
          } else if (state is TutorialSuccessState) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  titleSpacing: 0.0,
                  title: index != 2
                      ? InkWell(
                          onTap: () {},
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 18, 16, 18),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPlaceScreen()));
                                    },
                                    child: const Text(
                                      'Пропустить',
                                      style: TextStyle(
                                        color: Color(0xFF4CAF50),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        height: 1.25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
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
                            _mainWidget(
                              size,
                              'assets/images/tutorial_1.svg',
                              'Добро пожаловать \nв Путеводитель',
                              'Ищи новые локации и сохраняй \nсамые любимые.',
                            ),
                            _mainWidget(
                              size,
                              'assets/images/tutorial_2.svg',
                              'Построй маршрут \nи отправляйся в путь',
                              'Достигай цели максимально \nбыстро и комфортно.',
                            ),
                            _mainWidget(
                              size,
                              'assets/images/tutorial_3.svg',
                              'Добавляй места,\nкоторые нашёл сам',
                              'Делись самыми интересными\nи помоги нам стать лучше!',
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        axisDirection: Axis.horizontal,
                        effect: const ExpandingDotsEffect(
                          activeDotColor: Color(0xFF4CAF50),
                          dotWidth: 8,
                          dotHeight: 8,
                          dotColor: Color(0x8F7C7E92),
                        ),
                      ),
                      if (index == 2) ...[
                        SizedBox(height: size.height * 0.04),
                        AppButtonWidget(
                          title: 'на старт',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewPlaceScreen()));
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
          return const SizedBox();
        },
      ),
    );
  }

  Widget _mainWidget(
    Size size,
    String assetName,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.12),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.23),
            SizedBox(
              height: size.height * 0.14,
              child: SvgPicture.asset(assetName),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF252849),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.28,
                color: Color(0xFF7C7E92),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
