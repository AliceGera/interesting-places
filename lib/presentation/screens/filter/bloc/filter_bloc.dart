import 'package:bloc/bloc.dart';
import 'package:interesting_places/presentation/enum/enum.dart';
import 'package:interesting_places/presentation/screens/filter/data/filter_screen_data.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterScreenData filterScreenData = FilterScreenData.init();

  FilterBloc() : super(FilterInitialState()) {
    on<LoadFilterEvent>((event, emit) async {
      emit(FilterLoadingState());
      try {
        emit(FilterSuccessState(filterScreenData));
      } catch (error) {
        emit(FilterFailedState(error.toString()));
      }
    });
    on<UpdateSelectedCategoriesListEvent>((event, emit) {
      if (filterScreenData.selectedCategories.contains(event.category)) {
        filterScreenData.selectedCategories.remove(event.category);
        filterScreenData = filterScreenData.copyWith(
          selectedCategories: filterScreenData.selectedCategories,
        );
      } else {
        filterScreenData = filterScreenData.copyWith(
          selectedCategories: [
            ...filterScreenData.selectedCategories,
            event.category,
          ],
        );
      }
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
