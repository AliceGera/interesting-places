import 'package:interesting_places/domain/model/place_list_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_list_screen_data.dart';
import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

abstract class PlaceListViewMapper {
  factory PlaceListViewMapper() => _PlaceListViewMapper();

  PlaceListScreenData toScreenData(
    PlaceListScreenData screenData,
    PlaceListData data,
  );
}

class _PlaceListViewMapper implements PlaceListViewMapper {
  @override
  PlaceListScreenData toScreenData(
    PlaceListScreenData screenData,
    PlaceListData data,
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
          ).copyWith(),
        )
        .toList();
    return screenData.copyWith(places: list);
  }
}
