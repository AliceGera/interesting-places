import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/filter/data/filter_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterScreenData filterScreenData = FilterScreenData.init();

  FilterBloc() : super(FilterInitialState()) {
    on<LoadFilterEvent>((event, emit) async {
      final selectedList = event.places
          .where(
            (e) => event.selectedCategories
                .where(
                  (element) => element.getCategoryTypeTitle() == e.category && e.distance > event.rangeValues.start && e.distance < event.rangeValues.end,
                )
                .toList()
                .isNotEmpty,
          )
          .toList();

      filterScreenData = filterScreenData.copyWith(
        places: event.places,
        selectedCategories: event.selectedCategories,
        rangeValues: event.rangeValues,
        sortedPlaces: selectedList,
      );
      emit(FilterSuccessState(filterScreenData));
    });
    on<UpdateSelectedCategoriesListEvent>((event, emit) {
      if (filterScreenData.selectedCategories.contains(event.category)) {
        var newSelectedCategories = List<CategoryType>.from(
          filterScreenData.selectedCategories,
        )..remove(event.category);
        filterScreenData = filterScreenData.copyWith(
          selectedCategories: newSelectedCategories,
        );
      } else {
        filterScreenData = filterScreenData.copyWith(
          selectedCategories: [
            ...filterScreenData.selectedCategories,
            event.category,
          ],
        );
      }
      final sortedPlaces = filterScreenData.places
          .where(
            (e) => filterScreenData.selectedCategories
                .where(
                  (element) =>
                      element.getCategoryTypeTitle() == e.category &&
                      e.distance > filterScreenData.rangeValues.start &&
                      e.distance < filterScreenData.rangeValues.end,
                )
                .toList()
                .isNotEmpty,
          )
          .toList();
      filterScreenData = filterScreenData.copyWith(
        sortedPlaces: sortedPlaces,
      );
      emit(FilterSuccessState(filterScreenData));
    });

    on<ChangeCurrentRangeValuesEvent>((event, emit) {
      filterScreenData = filterScreenData.copyWith(
        rangeValues: event.rangeValues,
      );
      final sortedPlaces = filterScreenData.places
          .where(
            (e) => filterScreenData.selectedCategories
                .where(
                  (element) =>
                      element.getCategoryTypeTitle() == e.category &&
                      e.distance > filterScreenData.rangeValues.start &&
                      e.distance < filterScreenData.rangeValues.end,
                )
                .toList()
                .isNotEmpty,
          )
          .toList();
      filterScreenData = filterScreenData.copyWith(
        sortedPlaces: sortedPlaces,
      );
      emit(FilterSuccessState(filterScreenData));
    });
    on<CleanSelectedCategoriesListEvent>((event, emit) {
      filterScreenData = filterScreenData.copyWith(
        selectedCategories: [],
      );
      emit(FilterSuccessState(filterScreenData));
    });
  }
}
