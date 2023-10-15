import 'package:get_it/get_it.dart';
import 'package:interesting_places/domain/interactor/place_list_interactor.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_view_mapper.dart';
import 'package:interesting_places/presentation/screens/place_map/bloc/place_map_bloc.dart';
import 'package:interesting_places/presentation/screens/place_map/place_map_view_mapper.dart';

void initPlaceMapModule() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<PlaceMapViewMapper>(() => PlaceMapViewMapper());
  getIt.registerFactory<PlaceMapBloc>(
    () => PlaceMapBloc(
      getIt.get<PlaceListInteractor>(),
      getIt.get<PlaceListViewMapper>(),
    ),
  );
}
