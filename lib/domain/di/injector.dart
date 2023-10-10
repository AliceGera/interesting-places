import 'package:get_it/get_it.dart';
import 'package:interesting_places/domain/interactor/add_new_place_interactor.dart';
import 'package:interesting_places/domain/interactor/place_list_interactor.dart';
import 'package:interesting_places/domain/repository/places_repository.dart';

Future<void> configureDomainDependencies() async {
  final getIt = GetIt.I;

  getIt.registerLazySingleton<PlaceListInteractor>(
    () => PlaceListInteractor(
      getIt.get<IPlacesRepository>(),
    ),
  );
  getIt.registerLazySingleton<AddNewPlaceInteractor>(
    () => AddNewPlaceInteractor(
      getIt.get<IPlacesRepository>(),
    ),
  );
}
