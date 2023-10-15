import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:interesting_places/domain/interactor/add_new_place_interactor.dart';
import 'package:interesting_places/presentation/screens/add_new_place/add_new_place_view_mapper.dart';
import 'package:interesting_places/presentation/screens/add_new_place/data/add_new_place_screen_data.dart';
import 'package:meta/meta.dart';

part 'add_new_place_event.dart';

part 'add_new_place_state.dart';

class AddNewPlaceBloc extends Bloc<AddNewPlaceEvent, AddNewPlaceState> {
  AddNewPlaceScreenData addNewPlaceScreenData = AddNewPlaceScreenData.init();

  final AddNewPlaceInteractor interactor;
  final AddNewPlaceViewMapper viewMapper;

  AddNewPlaceBloc(
    this.interactor,
    this.viewMapper,
  ) : super(AddNewPlaceInitialState()) {
    on<LoadAddNewPlaceEvent>((event, emit) {
      emit(AddNewPlaceInitialState());
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });

    on<AddPhotoForNewPlaceEvent>((event, emit) {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        photo: [
          ...addNewPlaceScreenData.photo,
          event.photo,
        ],
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });

    on<RemovePhotoForNewPlaceEvent>((event, emit) {
      addNewPlaceScreenData.photo.removeAt(event.index);
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        photo: addNewPlaceScreenData.photo,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });

    on<AddCategoryForNewPlaceEvent>((event, emit) {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        category: event.category,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });
    on<SaveIndexForNewPlaceEvent>((event, emit) {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        index: event.index,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });

    on<SaveNameForNewPlaceEvent>((event, emit) {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        name: event.name,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });
    on<SaveLongitudeForNewPlaceEvent>((event, emit) async {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        longitude: event.longitude,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });
    on<SaveLatitudeForNewPlaceEvent>((event, emit) async {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        latitude: event.latitude,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });
    on<SaveDescriptionForNewPlaceEvent>((event, emit) async {
      addNewPlaceScreenData = addNewPlaceScreenData.copyWith(
        description: event.description,
      );
      emit(AddNewPlaceSuccessState(addNewPlaceScreenData));
    });
    on<CreateNewPlaceEvent>((event, emit) async {
      emit(AddNewPlaceLoadingState());
      try {
        final data = viewMapper.toAddNewPlaceData(addNewPlaceScreenData);
        await interactor.putPlaceToDatabase(data);
        emit(AddNewPlaceFinishState());
      } catch (error) {
        emit(AddNewPlaceFailedState(Exception(error)));
      }
    });
  }
}
