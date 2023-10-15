import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitialState()) {
    on<LoadFilterEvent>((event, emit) async {
      emit(FilterLoadingState());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(FilterSuccessState());
      } catch (error) {
        emit(FilterFailedState(error.toString()));
      }
    });
  }
}
