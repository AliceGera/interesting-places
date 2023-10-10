part of 'place_list_bloc.dart';

@immutable
sealed class PlaceListState {}

class PlaceListInitialState extends PlaceListState {}

class PlaceListLoadingState implements PlaceListState {}

class PlaceListSuccessState implements PlaceListState {
  final PlaceListScreenData data;

  PlaceListSuccessState(this.data);
}

class PlaceListFailedState implements PlaceListState {
  final dynamic error;

  PlaceListFailedState(this.error);
}
