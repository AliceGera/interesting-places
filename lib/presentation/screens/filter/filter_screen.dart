import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/filter/bloc/filter_bloc.dart';
import 'package:interesting_places/presentation/screens/filter/widget/app_bar_filter_widget.dart';
import 'package:interesting_places/presentation/screens/filter/widget/category_table_widget.dart';
import 'package:interesting_places/presentation/screens/filter/widget/filter_slider_widget.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
import 'package:interesting_places/presentation/widget/app_button_widget.dart';
import 'package:interesting_places/presentation/widget/indicator_widget.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  const FilterScreen({
    Key? key,
    required this.places,
    required this.selectedCategories,
    required this.rangeValues,
    required this.callback,
  }) : super(key: key);
  final void Function(
    List<CategoryType> selectedCategories,
    RangeValues rangeValues,
    List<PlaceScreenData> sortedPlaces,
  ) callback;
  final List<PlaceScreenData> places;
  final List<CategoryType> selectedCategories;
  final RangeValues rangeValues;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => FilterBloc()
        ..add(LoadFilterEvent(
          widget.selectedCategories,
          widget.rangeValues,
          widget.places,
          // widget.sortedPlaces,
        )),
      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {
          switch (state) {
            case FilterLoadingState() || FilterInitialState():
              return const CircularProgressIndicatorWidget();
            case FilterFailedState():
              return const CircularProgressIndicatorWidget();
            case FilterSuccessState():
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColor.white,
                  appBar: AppBarFilterWidget(
                    clickCallback: () {
                      BlocProvider.of<FilterBloc>(context).add(
                        CleanSelectedCategoriesListEvent(),
                      );
                    },
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'категории'.toUpperCase(),
                          style: AppTextStyle.superSmall.copyWith(
                            color: AppColor.inactiveBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  CategoryTableWidget(
                                    category: CategoryType.hotel,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(UpdateSelectedCategoriesListEvent(CategoryType.hotel));
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.hotel),
                                  ),
                                  CategoryTableWidget(
                                    category: CategoryType.restaurant,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(
                                        UpdateSelectedCategoriesListEvent(
                                          CategoryType.restaurant,
                                        ),
                                      );
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.restaurant),
                                  ),
                                  CategoryTableWidget(
                                    category: CategoryType.particularPlace,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(
                                        UpdateSelectedCategoriesListEvent(
                                          CategoryType.particularPlace,
                                        ),
                                      );
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.particularPlace),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  CategoryTableWidget(
                                    category: CategoryType.park,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(UpdateSelectedCategoriesListEvent(CategoryType.park));
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.park),
                                  ),
                                  CategoryTableWidget(
                                    category: CategoryType.museum,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(UpdateSelectedCategoriesListEvent(CategoryType.museum));
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.museum),
                                  ),
                                  CategoryTableWidget(
                                    category: CategoryType.cafe,
                                    callback: () {
                                      BlocProvider.of<FilterBloc>(context).add(UpdateSelectedCategoriesListEvent(CategoryType.cafe));
                                    },
                                    isCheck: state.data.selectedCategories.contains(CategoryType.cafe),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Расстояние',
                              style: AppTextStyle.subtitleLite,
                            ),
                            Text(
                              'от ${state.data.rangeValues.start.round().toString()} до ${state.data.rangeValues.end.round().toString()} км',
                              style: AppTextStyle.subtitleLite.copyWith(
                                color: AppColor.secondary2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: FilterSliderWidget(
                            currentRangeValues: state.data.rangeValues,
                            callbackCurrentRangeValues: (RangeValues values) {
                              BlocProvider.of<FilterBloc>(context).add(
                                ChangeCurrentRangeValuesEvent(values),
                              );
                            },
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppButtonWidget(
                            title: 'показать ${state.data.sortedPlaces.length}',
                            onPressed: () {
                              widget.callback.call(
                                state.data.selectedCategories,
                                state.data.rangeValues,
                                state.data.sortedPlaces,
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ),
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
