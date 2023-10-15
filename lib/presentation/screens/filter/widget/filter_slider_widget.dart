import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';

typedef FilterSliderCallback = void Function(RangeValues values);

class FilterSliderWidget extends StatefulWidget {
  const FilterSliderWidget({
    super.key,
    required this.currentRangeValues,
    required this.callbackCurrentRangeValues,
  });

  final RangeValues currentRangeValues;

  final FilterSliderCallback callbackCurrentRangeValues;

  @override
  State<FilterSliderWidget> createState() => _FilterSliderWidgetState();
}

class _FilterSliderWidgetState extends State<FilterSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
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
        values: widget.currentRangeValues,
        max: 30,
        labels: RangeLabels(
          widget.currentRangeValues.start.round().toString(),
          widget.currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          widget.callbackCurrentRangeValues.call(values);
        },
      ),
    );
  }
}
