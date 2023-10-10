import 'package:interesting_places/data/database/database.dart';
import 'package:interesting_places/domain/model/add_new_place_data.dart';
import 'package:interesting_places/domain/model/place_list_data.dart';
import 'package:interesting_places/domain/repository/places_repository.dart';

class ApiPlacesRepository implements IPlacesRepository {
  final PlacesDatabase appDatabase;

  ApiPlacesRepository(this.appDatabase);

  @override
  Future<PlaceListData> getPlaceList() async {
    final some = await appDatabase.select(appDatabase.placesView).get();
    final list = some
        .map(
          (e) => PlaceData(
            description: e.description,
            name: e.name,
            longitude: e.longitude,
            latitude: e.latitude,
            category: e.category,
            photo: [e.data],
          ),
        )
        .toList();
    return PlaceListData(places: list);
  }

  @override
  Future<void> putPlaceToDatabase(AddNewPlaceData data) async {
    final id = await appDatabase.into(appDatabase.places).insert(
          PlacesCompanion.insert(
            category: data.category ?? '',
            name: data.name ?? '',
            description: data.description ?? '',
            latitude: data.latitude ?? '',
            longitude: data.longitude ?? '',
          ),
        );
    if (data.photo != null) {
      for (var photo in data.photo!) {
        await appDatabase.into(appDatabase.images).insert(
              ImagesCompanion.insert(
                data: photo,
                placeId: id,
              ),
            );
      }
    }
  }
}
