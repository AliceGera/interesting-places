import 'package:interesting_places/presentation/screens/place_list/data/place_screen_data.dart';

class PlaceListScreenData {
  final List<PlaceScreenData> places;

  PlaceListScreenData(this.places);

  static PlaceListScreenData init() => PlaceListScreenData([]);

  PlaceListScreenData copyWith({
    List<PlaceScreenData>? places,
  }) =>
      PlaceListScreenData(places ?? this.places);
}
