import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:interesting_places/screens/add_new_place/data/add_new_place_screen_data.dart';
import 'package:meta/meta.dart';

part 'add_new_place_event.dart';

part 'add_new_place_state.dart';

class AddNewPlaceBloc extends Bloc<AddNewPlaceEvent, AddNewPlaceState> {
  AddNewPlaceScreenData addNewPlaceScreenData = AddNewPlaceScreenData.init();

  AddNewPlaceBloc() : super(AddNewPlaceInitialState()) {
    on<LoadAddNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceInitialState());
      emit(AddNewPlaceLoadingState());
      try {
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
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
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });

    on<RemovePhotoForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData.photo.removeAt(event.index);
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          photo: addNewPlaceScreenData.photo,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });

    on<AddCategoryForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          category: event.category,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
    on<SaveIndexForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          index: event.index,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });

    on<SaveNameForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          name: event.name,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
    on<SaveLongitudeForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          longitude: event.longitude,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
    on<SaveLatitudeForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          latitude: event.latitude,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
    on<SaveDescriptionForNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
          description: event.description,
        );
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
  }
}
