import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:interesting_places/database/database.dart';
import 'package:interesting_places/screens/add_new_place/data/add_new_place_screen_data.dart';
import 'package:meta/meta.dart';

part 'add_new_place_event.dart';

part 'add_new_place_state.dart';

class AddNewPlaceBloc extends Bloc<AddNewPlaceEvent, AddNewPlaceState> {
  AddNewPlaceScreenData addNewPlaceScreenData = AddNewPlaceScreenData.init();
  final appDataBase = AppDatabase();

  AddNewPlaceBloc() : super(AddNewPlaceInitialState()) {
    on<LoadAddNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceInitialState());
      emit(AddNewPlaceLoadingState());
      try {
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
        //await Future.delayed(Duration(seconds: 2));
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
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
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
        emit(AddNewPlaceFailedState('sss'));
      }
    });

    on<CreateNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        appDataBase.into(appDataBase.places).insert(
              PlacesCompanion.insert(
                category: addNewPlaceScreenData.category,
                name: addNewPlaceScreenData.name,
                description: addNewPlaceScreenData.description,
                latitude: addNewPlaceScreenData.latitude,
                longitude: addNewPlaceScreenData.longitude,
              ),
            );
        List<Place> places = await appDataBase.select(appDataBase.places).get();
        print('items in database: $places');
        emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
      } catch (error) {
        emit(AddNewPlaceFailedState('sss'));
      }
    });
  }
}
