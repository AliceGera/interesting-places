import 'package:interesting_places/presentation/screens/add_new_place/add_new_place_module.dart';
import 'package:interesting_places/presentation/screens/place_list/place_list_module.dart';
import 'package:interesting_places/presentation/screens/place_map/place_map_module.dart';

Future<void> configurePresentationDependencies() async {
  initAddNewPlaceModule();
  initPlaceListModule();
  initPlaceMapModule();
}
