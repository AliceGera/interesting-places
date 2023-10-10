import 'package:interesting_places/domain/model/place_list_data.dart';
import 'package:interesting_places/domain/repository/places_repository.dart';

class PlaceListInteractor {
  final IPlacesRepository placesRepository;

  PlaceListInteractor(this.placesRepository);

  Future<PlaceListData> getPlaceList() {
    return placesRepository.getPlaceList();
  }
}
