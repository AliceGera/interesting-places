import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/filter/bloc/filter_bloc.dart';
import 'package:interesting_places/presentation/screens/filter/widget/category_table_widget.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
import 'package:interesting_places/presentation/widget/app_button_widget.dart';
import 'package:interesting_places/presentation/widget/indicator_widget.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  RangeValues _currentRangeValues = const RangeValues(0, 30);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => FilterBloc()..add(LoadFilterEvent()),
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
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(AppImages.arrow),
                        Text(
                          'Очистить',
                          style: AppTextStyle.subtitle.copyWith(
                            color: AppColor.green,
                          ),
                        ),
                      ],
                    ),
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
                            children: const <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  CategoryTableWidget(category: 'category'),
                                  CategoryTableWidget(category: 'category'),
                                  CategoryTableWidget(category: 'category'),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  CategoryTableWidget(category: 'category'),
                                  CategoryTableWidget(category: 'category'),
                                  CategoryTableWidget(category: 'category'),
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
                              'от ${_currentRangeValues.start.round().toString()} до ${_currentRangeValues.end.round().toString()} км',
                              style: AppTextStyle.subtitleLite.copyWith(
                                color: AppColor.secondary2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 1.0,
                              thumbColor: Colors.white,
                              overlayColor: AppColor.inactiveBlack,
                              overlayShape: const RoundSliderThumbShape(disabledThumbRadius: 1.0),
                              inactiveTrackColor: AppColor.inactiveBlack,
                              activeTrackColor: AppColor.green,
                            ),
                            child: RangeSlider(
                              min: 0,
                              values: _currentRangeValues,
                              max: 30,
                              labels: RangeLabels(
                                _currentRangeValues.start.round().toString(),
                                _currentRangeValues.end.round().toString(),
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _currentRangeValues = values;
                                });
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: AppButtonWidget(title: 'показать (190)'),
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
