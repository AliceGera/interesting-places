part of 'tutorial_bloc.dart';

abstract class TutorialState {}

class TutorialInitialState extends TutorialState {}

class TutorialLoadingState extends TutorialState {}

class TutorialSuccessState extends TutorialState {}

class TutorialFailedState extends TutorialState {
  final dynamic error;
  TutorialFailedState(this.error);
}
