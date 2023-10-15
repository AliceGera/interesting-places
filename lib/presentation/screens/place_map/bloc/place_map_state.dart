part of 'place_map_bloc.dart';

@immutable
abstract class PlaceMapState {}

class PlaceMapInitialState extends PlaceMapState {}

class PlaceMapLoadingState implements PlaceMapState {}

class PlaceMapSuccessState implements PlaceMapState {
  final PlaceListScreenData data;
  final PlaceScreenData? selectedPlaceScreenData;
  PlaceMapSuccessState(this.data,this.selectedPlaceScreenData);
}

class PlaceMapFailedState implements PlaceMapState {
  final dynamic error;

  PlaceMapFailedState(this.error);
}
