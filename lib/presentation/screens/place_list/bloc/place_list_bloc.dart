import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interesting_places/domain/interactor/place_list_interactor.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_list_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_view_mapper.dart';
import 'package:meta/meta.dart';

part 'place_list_event.dart';

part 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceListInteractor interactor;
  final PlaceListViewMapper viewMapper;
  PlaceListScreenData screenData = PlaceListScreenData.init();

  PlaceListBloc(
    this.interactor,
    this.viewMapper,
  ) : super(PlaceListInitialState()) {
    on<LoadPlaceListEvent>((event, emit) async {
      {
        emit(PlaceListLoadingState());
        try {
          final data = await interactor.getPlaceList();
          final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
          final position = await geolocatorPlatform.getCurrentPosition();

          screenData = viewMapper.toScreenData(
            screenData,
            data,
            position,
          );
          emit(PlaceListSuccessState(screenData));
        } catch (error) {
          emit(PlaceListFailedState(error.toString()));
        }
      }
    });
  }
}
