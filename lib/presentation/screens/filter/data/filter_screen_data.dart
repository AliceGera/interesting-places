import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

class FilterScreenData {
  final List<CategoryType> selectedCategories;
  final List<PlaceScreenData> places;
  final List<PlaceScreenData> sortedPlaces;
  final RangeValues rangeValues;

  FilterScreenData(
    this.selectedCategories,
    this.places,
    this.sortedPlaces,
    this.rangeValues,
  );

  static FilterScreenData init() => FilterScreenData(
        [],
        [],
        [],
        const RangeValues(0, 30),
      );

  FilterScreenData copyWith({
    List<CategoryType>? selectedCategories,
    List<PlaceScreenData>? places,
    List<PlaceScreenData>? sortedPlaces,
    RangeValues? rangeValues,
  }) =>
      FilterScreenData(
        selectedCategories ?? this.selectedCategories,
        places ?? this.places,
        sortedPlaces ?? this.sortedPlaces,
        rangeValues ?? this.rangeValues,
      );
}
