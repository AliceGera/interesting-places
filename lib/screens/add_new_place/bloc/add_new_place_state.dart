part of 'add_new_place_bloc.dart';

@immutable
abstract class AddNewPlaceState {}

class AddNewPlaceInitialState extends AddNewPlaceState {}

class AddNewPlaceLoadingState extends AddNewPlaceState {}

class AddNewPlaceSuccessState extends AddNewPlaceState {
  final AddNewPlaceScreenData data;

  AddNewPlaceSuccessState(this.data);
}

class AddNewPlaceFailedState extends AddNewPlaceState {
  final dynamic error;

  AddNewPlaceFailedState(this.error);
}