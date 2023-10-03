import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/add_new_place_screen_data.dart';

part 'add_new_place_event.dart';

part 'add_new_place_state.dart';

class AddNewPlaceBloc extends Bloc<AddNewPlaceEvent, AddNewPlaceState> {
  AddNewPlaceBloc() : super(AddNewPlaceInitialState()) {
    AddNewPlaceScreenData addNewPlaceScreenData = AddNewPlaceScreenData.init();
    on<AddNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        await Future.delayed(Duration(seconds: 2));
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState('sss'));
      }
    });

    on<AddPhotoForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          photo: [
            ...addNewPlaceScreenData.photo,
            event.photo,
          ],
        );
        await Future.delayed(Duration(seconds: 2));
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState('sss'));
      }
    });

    on<RemovePhotoForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData.photo.removeAt(event.index);
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          photo: addNewPlaceScreenData.photo,
        );
        await Future.delayed(Duration(seconds: 2));
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState('sss'));
      }
    });
  }
}
