part of 'filter_bloc.dart';

@immutable
sealed class FilterState {}

class FilterInitialState implements FilterState {}

class FilterLoadingState implements FilterState {}

class FilterSuccessState implements FilterState {}

class FilterFailedState implements FilterState {
  final dynamic error;

  FilterFailedState(this.error);
}
