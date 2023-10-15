import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

class PlaceListScreenData {
  final List<PlaceScreenData> places;
  final List<PlaceScreenData> sortedPlaces;
  final List<CategoryType> selectedCategories;
  final RangeValues rangeValues;

  PlaceListScreenData(
    this.places,
    this.sortedPlaces,
    this.selectedCategories,
    this.rangeValues,
  );

  static PlaceListScreenData init() => PlaceListScreenData(
        [],
        [],
        CategoryType.values,
        const RangeValues(0, 30),
      );

  PlaceListScreenData copyWith({
    List<PlaceScreenData>? places,
    List<PlaceScreenData>? sortedPlaces,
    List<CategoryType>? selectedCategories,
     RangeValues? rangeValues,
  }) =>
      PlaceListScreenData(
        places ?? this.places,
        sortedPlaces ?? this.sortedPlaces,
        selectedCategories ?? this.selectedCategories,
        rangeValues ?? this.rangeValues,
      );
}
