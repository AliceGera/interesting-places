import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'app_bar_map_widget.dart';
class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late YandexMapController controller;
  late final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: cameraMapObjectId,
      point: const Point(latitude: 55.755848, longitude: 37.620409),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/images/place.png'), scale: 0.75)),
      opacity: 0.5,
    )
  ];

  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark');
  final animation = const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  GlobalKey mapKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBarMapWidget(clickCallback: _clickCallback),
        body: Stack(
          alignment: Alignment.bottomRight,
          children: [
            YandexMap(
              key: mapKey,
              mapObjects: mapObjects,
              onCameraPositionChanged: (CameraPosition cameraPosition, CameraUpdateReason _, bool __) async {
                final placemarkMapObject = mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId) as PlacemarkMapObject;
                setState(
                  () {
                    mapObjects[mapObjects.indexOf(placemarkMapObject)] = placemarkMapObject.copyWith(point: cameraPosition.target);
                  },
                );
              },
              onMapCreated: (YandexMapController yandexMapController) async {
                final placemarkMapObject = mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId) as PlacemarkMapObject;
                controller = yandexMapController;
                await controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: placemarkMapObject.point, zoom: 17)));
              },
              onUserLocationAdded: (UserLocationView view) async {
                return view.copyWith(
                  pin: view.pin.copyWith(icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/user.png')))),
                  arrow: view.arrow.copyWith(icon: PlacemarkIcon.single(PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('lib/assets/arrow.png')))),
                  accuracyCircle: view.accuracyCircle.copyWith(fillColor: Colors.green.withOpacity(0.5)),
                );
              },
            ),
            InkWell(
              onTap: () async {
                await _checkPermission();
                final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
                final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;
                await controller.toggleUserLayer(
                  autoZoomEnabled: true,
                  visible: true,
                  anchor: UserLocationAnchor(
                    course: Offset(0.5 * width, 0.5 * height),
                    normal: Offset(0.5 * width, 0.5 * height),
                  ),
                );
                final position = await _geolocatorPlatform.getCurrentPosition();
                await controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      ),
                    ),
                  ),
                  animation: animation,
                );
              },
              child: SvgPicture.asset(AppImages.geo),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage(Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }

  Future<void> _checkPermission() async {
    final permission = await _geolocatorPlatform.checkPermission();
    if (!(permission == LocationPermission.always || permission == LocationPermission.whileInUse)) {
      final requestPermission = await _geolocatorPlatform.requestPermission();
      if (!(requestPermission == LocationPermission.always || requestPermission == LocationPermission.whileInUse)) {
        _showMessage(const Text('Разрешение на определение точного местоположения не предоставлено.'));
        return;
      }
    }
  }

  Future<void> _clickCallback() async {
    await controller.getCameraPosition().then((value) => Navigator.of(context).pop(value));
  }
}
