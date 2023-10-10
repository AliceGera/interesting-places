import 'package:get_it/get_it.dart';
import 'package:interesting_places/domain/interactor/add_new_place_interactor.dart';
import 'package:interesting_places/presentation/screens/add_new_place/add_new_place_view_mapper.dart';
import 'package:interesting_places/presentation/screens/add_new_place/bloc/add_new_place_bloc.dart';

void initAddNewPlaceModule() {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<AddNewPlaceViewMapper>(() => AddNewPlaceViewMapper());
  getIt.registerFactory<AddNewPlaceBloc>(
    () => AddNewPlaceBloc(
      getIt.get<AddNewPlaceInteractor>(),
      getIt.get<AddNewPlaceViewMapper>(),
    ),
  );
}
