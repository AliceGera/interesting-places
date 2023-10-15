import 'package:interesting_places/domain/model/add_new_place_data.dart';
import 'package:interesting_places/presentation/screens/add_new_place/data/add_new_place_screen_data.dart';

abstract class AddNewPlaceViewMapper {
  factory AddNewPlaceViewMapper() => _AddNewPlaceViewMapper();

  AddNewPlaceData toAddNewPlaceData(AddNewPlaceScreenData screenData);
}

class _AddNewPlaceViewMapper implements AddNewPlaceViewMapper {
  @override
  AddNewPlaceData toAddNewPlaceData(AddNewPlaceScreenData screenData) {
    return AddNewPlaceData(
      photo: screenData.photo,
      category: screenData.category,
      name: screenData.name,
      latitude: screenData.latitude,
      longitude: screenData.longitude,
      description: screenData.description,
    );
  }
}
