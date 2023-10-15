import 'package:interesting_places/data/database/database.dart';
import 'package:interesting_places/data/repository/api_global_repository.dart';
import 'package:interesting_places/domain/repository/places_repository.dart';
import 'package:get_it/get_it.dart';

Future<void> configureDataDependencies() async {
  final getIt = GetIt.I;
  getIt.registerLazySingleton<PlacesDatabase>(
    () => PlacesDatabase(),
  );
  getIt.registerLazySingleton<IPlacesRepository>(
    () => ApiPlacesRepository(
      getIt.get<PlacesDatabase>(),
    ),
  );
}
