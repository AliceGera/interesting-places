import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interesting_places/domain/interactor/place_list_interactor.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_list_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_view_mapper.dart';

part 'place_map_event.dart';

part 'place_map_state.dart';

class PlaceMapBloc extends Bloc<PlaceMapEvent, PlaceMapState> {
  final PlaceListInteractor interactor;
  final PlaceListViewMapper viewMapper;
  PlaceListScreenData screenData = PlaceListScreenData.init();
  PlaceScreenData? selectedPlaceScreenData;

  PlaceMapBloc(
    this.interactor,
    this.viewMapper,
  ) : super(PlaceMapInitialState()) {
    on<LoadPlaceMapEvent>((event, emit) async {
      {
        emit(PlaceMapLoadingState());
        try {
          final data = await interactor.getPlaceList();
          final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
          final position = await geolocatorPlatform.getCurrentPosition();

          screenData = viewMapper.toScreenData(
            screenData,
            data,
            position,
          );
          final myPosition = PlaceScreenData.init().copyWith(
            longitude: position.longitude.toString(),
            latitude: position.latitude.toString(),
          );
          screenData = screenData.copyWith(
            places: [
              myPosition,
              ...screenData.places,
            ],
            sortedPlaces: [
              myPosition,
              ...screenData.sortedPlaces,
            ],
          );

          emit(PlaceMapSuccessState(screenData, selectedPlaceScreenData));
        } catch (error) {
          emit(PlaceMapFailedState(error.toString()));
        }
      }
    });
    on<ChanceValuesPlaceMapEvent>((event, emit) async {
      final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
      final position = await geolocatorPlatform.getCurrentPosition();

      final selectedList = screenData.places
          .where(
            (e) => event.selectedCategories
                .where(
                  (element) => element.getCategoryTypeTitle() == e.category && e.distance >= event.rangeValues.start && e.distance <= event.rangeValues.end,
                )
                .toList()
                .isNotEmpty,
          )
          .toList();
      final myPosition = PlaceScreenData.init().copyWith(
        longitude: position.longitude.toString(),
        latitude: position.latitude.toString(),
      );
      screenData = screenData.copyWith(
        sortedPlaces: [
          myPosition,
          ...selectedList,
        ],
        rangeValues: event.rangeValues,
        selectedCategories: event.selectedCategories,
      );
      emit(PlaceMapSuccessState(screenData, selectedPlaceScreenData));
    });

    on<UpdatePlaceMapEvent>((event, emit) async {
      try {
        final data = await interactor.getPlaceList();
        final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
        final position = await geolocatorPlatform.getCurrentPosition();
        screenData = viewMapper.toScreenData(
          screenData,
          data,
          position,
        );
        final myPosition = PlaceScreenData.init().copyWith(
          longitude: position.longitude.toString(),
          latitude: position.latitude.toString(),
        );
        screenData = screenData.copyWith(
          places: [
            myPosition,
            ...screenData.places,
          ],
          sortedPlaces: [
            myPosition,
            ...screenData.sortedPlaces,
          ],
        );
        emit(PlaceMapSuccessState(screenData, selectedPlaceScreenData));
      } catch (error) {
        emit(PlaceMapFailedState(error.toString()));
      }
    });

    on<AddInfoWidgetPlaceMapEvent>((event, emit) {
      final selectedPlace = screenData.places.firstWhere((element) =>
          double.parse(double.parse(element.latitude).toStringAsFixed(2)) == double.parse(event.latitude.toStringAsFixed(2)) &&
          double.parse(double.parse(element.longitude).toStringAsFixed(2)) == double.parse(event.longitude.toStringAsFixed(2)));

      selectedPlaceScreenData = PlaceScreenData.init().copyWith(
        photo: selectedPlace.photo,
        name: selectedPlace.name,
        latitude: selectedPlace.latitude,
        longitude: selectedPlace.longitude,
        description: selectedPlace.description,
        distance: selectedPlace.distance,
      );
      emit(PlaceMapSuccessState(screenData, selectedPlaceScreenData));
    });
    on<RemoveInfoWidgetPlaceMapEvent>((event, emit) {
      selectedPlaceScreenData = null;
      emit(PlaceMapSuccessState(screenData, selectedPlaceScreenData));
    });
  }
}
