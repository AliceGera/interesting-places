import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interesting_places/screens/place_list/widget/add_new_place_button_widget.dart';
import 'package:interesting_places/screens/place_list/widget/find_place_text_field_widget.dart';
import 'package:interesting_places/screens/place_list/widget/place_widget.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';
import 'package:interesting_places/widget/bottom_navigation_bar.dart';
import 'package:interesting_places/widget/indicator_widget.dart';
import 'bloc/place_list_bloc.dart';

class PlaceListScreen extends StatefulWidget {
  static const routeName = '/place_list';

  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  State<PlaceListScreen> createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PlaceListBloc()..add(LoadPlaceListEvent()),
      child: BlocBuilder<PlaceListBloc, PlaceListState>(
        builder: (context, state) {
          switch (state) {
            case PlaceListLoadingState() || PlaceListInitialState():
              return const CircularProgressIndicatorWidget();
            case PlaceListFailedState():
              return const CircularProgressIndicatorWidget();
            case PlaceListSuccessState():
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColor.white,
                  appBar: AppBar(
                    title: Text(
                      'Список интересных мест',
                      style: AppTextStyle.subtitle.copyWith(
                        color: AppColor.main,
                      ),
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 28),
                          child: FindPlaceTextFieldWidget(),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) => SizedBox(
                                  height: size.height * 0.25,
                                  child: const PlaceWidget(),
                                ),
                                separatorBuilder: (BuildContext context, int index) => Container(height: 12),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: AddNewPlaceButtonWidget(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: const BottomNavigationBarWidget(),
                ),
              );
          }
        },
      ),
    );
  }
}
