import 'package:geolocator/geolocator.dart';
import 'package:interesting_places/domain/model/place_list_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_list_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

abstract class PlaceListViewMapper {
  factory PlaceListViewMapper() => _PlaceListViewMapper();

  PlaceListScreenData toScreenData(
    PlaceListScreenData screenData,
    PlaceListData data,
    Position position,
  );
}

class _PlaceListViewMapper implements PlaceListViewMapper {
  @override
  PlaceListScreenData toScreenData(
    PlaceListScreenData screenData,
    PlaceListData data,
    Position position,
  ) {
    final list = data.places
        ?.map(
          (e) => PlaceScreenData(
            e.photo ?? [],
            e.category ?? '',
            e.name ?? '',
            e.latitude ?? '',
            e.longitude ?? '',
            e.description ?? '',
            Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  double.tryParse(e.latitude ?? '') ?? 0.0,
                  double.tryParse(e.longitude ?? '') ?? 0.0,
                ) /
                1000.0,
          ).copyWith(),
        )
        .toList();
    return screenData.copyWith(places: list);
  }
}
