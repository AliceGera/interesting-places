part of 'tutorial_bloc.dart';

sealed class TutorialState {}

class TutorialInitialState implements TutorialState {}

class TutorialLoadingState implements TutorialState {}

class TutorialSuccessState implements TutorialState {}

class TutorialFailedState implements TutorialState {
  final Exception error;

  TutorialFailedState(this.error);
}
