import 'package:interesting_places/domain/model/add_new_place_data.dart';
import 'package:interesting_places/domain/model/place_list_data.dart';
import 'package:interesting_places/domain/repository/places_repository.dart';

class AddNewPlaceInteractor {
  final IPlacesRepository addNewPlaceRepository;

  AddNewPlaceInteractor(this.addNewPlaceRepository);

  Future<void> putPlaceToDatabase(AddNewPlaceData data) {
    return addNewPlaceRepository.putPlaceToDatabase(data);
  }

  Future<PlaceListData> getPlaceList() {
    return addNewPlaceRepository.getPlaceList();
  }
}
