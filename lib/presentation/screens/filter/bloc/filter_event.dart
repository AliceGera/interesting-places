part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class LoadFilterEvent extends FilterEvent {
  final List<CategoryType> selectedCategories;
  final RangeValues rangeValues;

  final List<PlaceScreenData> places;

  LoadFilterEvent(
    this.selectedCategories,
    this.rangeValues,
    this.places,
  );
}

class UpdateSelectedCategoriesListEvent extends FilterEvent {
  final CategoryType category;

  UpdateSelectedCategoriesListEvent(this.category);
}

class CleanSelectedCategoriesListEvent extends FilterEvent {
  CleanSelectedCategoriesListEvent();
}

class ChangeCurrentRangeValuesEvent extends FilterEvent {
  final RangeValues rangeValues;

  ChangeCurrentRangeValuesEvent(this.rangeValues);
}
