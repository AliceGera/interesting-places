import 'dart:async';
import 'package:bloc/bloc.dart';

part 'tutorial_event.dart';

part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc() : super(TutorialInitialState()) {
    on<LoadTutorialEvent>((event, emit) async {
      emit(TutorialLoadingState());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(TutorialSuccessState());
      } catch (error) {
        emit(TutorialFailedState(error.toString()));
      }
    });
  }
}
