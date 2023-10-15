import 'package:interesting_places/domain/model/add_new_place_data.dart';
import 'package:interesting_places/domain/model/place_list_data.dart';

abstract class IPlacesRepository {
  Future<PlaceListData> getPlaceList();
  Future<void> putPlaceToDatabase(AddNewPlaceData data);
}
