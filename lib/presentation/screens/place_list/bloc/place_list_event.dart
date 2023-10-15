part of 'place_list_bloc.dart';

@immutable
abstract class PlaceListEvent {}

class LoadPlaceListEvent extends PlaceListEvent {}

class ChanceValuesPlaceListEvent extends PlaceListEvent {
  final List<PlaceScreenData> sortedPlaces;
  final List<CategoryType> selectedCategories;
  final RangeValues rangeValues;

  ChanceValuesPlaceListEvent(
    this.sortedPlaces,
    this.rangeValues,
    this.selectedCategories,
  );
}

class UpdatePlaceListEvent extends PlaceListEvent {
  UpdatePlaceListEvent();
}
