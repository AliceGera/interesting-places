import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'place_list_event.dart';
part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  PlaceListBloc() : super(PlaceListInitialState()) {
    on<LoadPlaceListEvent>((event, emit) async {
      emit(PlaceListLoadingState());
      try {
        await Future.delayed(const Duration(seconds: 2));
        emit(PlaceListSuccessState());
      } catch (error) {
        emit(PlaceListFailedState(Exception('error')));
      }
    });
  }
}
