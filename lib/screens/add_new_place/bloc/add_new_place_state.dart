part of 'add_new_place_bloc.dart';

@immutable
sealed class AddNewPlaceState {}

class AddNewPlaceInitialState implements AddNewPlaceState {}

class AddNewPlaceLoadingState implements AddNewPlaceState {}

class AddNewPlaceSuccessState implements AddNewPlaceState {
  final AddNewPlaceScreenData data;

  AddNewPlaceSuccessState(this.data);
}

class AddNewPlaceFailedState implements AddNewPlaceState {
  final Exception error;

  AddNewPlaceFailedState(this.error);
}
