import 'package:get_it/get_it.dart';
import 'package:interesting_places/domain/interactor/place_list_interactor.dart';
import 'package:interesting_places/presentation/screens/place_list/bloc/place_list_bloc.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_view_mapper.dart';

void initPlaceListModule() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<PlaceListViewMapper>(() => PlaceListViewMapper());
  getIt.registerFactory<PlaceListBloc>(
    () => PlaceListBloc(
      getIt.get<PlaceListInteractor>(),
      getIt.get<PlaceListViewMapper>(),
    ),
  );
}
