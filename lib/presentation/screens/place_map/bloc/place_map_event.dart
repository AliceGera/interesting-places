part of 'place_map_bloc.dart';

@immutable
abstract class PlaceMapEvent {}

class LoadPlaceMapEvent extends PlaceMapEvent {}

class ChanceValuesPlaceMapEvent extends PlaceMapEvent {
  final List<PlaceScreenData> sortedPlaces;
  final List<CategoryType> selectedCategories;
  final RangeValues rangeValues;

  ChanceValuesPlaceMapEvent(
      this.sortedPlaces,
      this.rangeValues,
      this.selectedCategories,
      );
}
class UpdatePlaceMapEvent extends PlaceMapEvent {

  UpdatePlaceMapEvent();
}
class AddInfoWidgetPlaceMapEvent extends PlaceMapEvent {
  final double latitude;
  final double longitude;
  AddInfoWidgetPlaceMapEvent(this.latitude,this.longitude);
}
class RemoveInfoWidgetPlaceMapEvent extends PlaceMapEvent {
  RemoveInfoWidgetPlaceMapEvent();
}