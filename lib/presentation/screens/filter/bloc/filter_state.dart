part of 'filter_bloc.dart';

@immutable
sealed class FilterState {}

class FilterInitialState implements FilterState {}

class FilterLoadingState implements FilterState {}

class FilterSuccessState implements FilterState {
  late FilterScreenData data;
  FilterSuccessState(this.data);
}

class FilterFailedState implements FilterState {
  final dynamic error;

  FilterFailedState(this.error);
}
