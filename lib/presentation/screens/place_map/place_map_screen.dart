import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:interesting_places/presentation/screens/add_new_place/add_new_place_screen.dart';
import 'package:interesting_places/presentation/screens/place_list/widget/add_new_place_button_widget.dart';
import 'package:interesting_places/presentation/screens/place_list/widget/find_place_text_field_widget.dart';
import 'package:interesting_places/presentation/screens/place_list/widget/place_widget.dart';
import 'package:interesting_places/presentation/screens/place_map/bloc/place_map_bloc.dart';
import 'package:interesting_places/presentation/utils/app_color.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
import 'package:interesting_places/presentation/utils/app_text_style.dart';
import 'package:interesting_places/presentation/widget/indicator_widget.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlaceMapScreen extends StatefulWidget {
  static const routeName = '/place_list';

  const PlaceMapScreen({Key? key}) : super(key: key);

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  late YandexMapController controller;

  final animation = const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  GlobalKey mapKey = GlobalKey();
  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark0');

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocProvider(
      create: (context) => GetIt.I.get<PlaceMapBloc>()..add(LoadPlaceMapEvent()),
      child: BlocBuilder<PlaceMapBloc, PlaceMapState>(
        builder: (context, state) {
          switch (state) {
            case PlaceMapLoadingState() || PlaceMapInitialState():
              return const CircularProgressIndicatorWidget();
            case PlaceMapFailedState():
              return const CircularProgressIndicatorWidget();
            case PlaceMapSuccessState():
              final mapsObject = state.data.sortedPlaces
                  .asMap()
                  .map(
                    (index, element) => MapEntry(
                      index,
                      PlacemarkMapObject(
                        onTap: (PlacemarkMapObject mapsObject, Point point) {
                          BlocProvider.of<PlaceMapBloc>(context).add(
                            AddInfoWidgetPlaceMapEvent(point.latitude, point.longitude),
                          );
                        },
                        mapId: MapObjectId('camera_placemark$index'),
                        point: Point(
                          latitude: double.tryParse(element.latitude) ?? 0.0,
                          longitude: double.tryParse(element.longitude) ?? 0.0,
                        ),
                        icon: PlacemarkIcon.single(
                          PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage(index != 0 ? 'assets/images/position.png' : 'assets/images/currentPosition.png'),
                            scale: 2,
                          ),
                        ),
                        opacity: 1,
                      ),
                    ),
                  )
                  .values
                  .toList();
              return SafeArea(
                child: Scaffold(
                  backgroundColor: AppColor.white,
                  appBar: AppBar(
                    title: Text(
                      'Карта',
                      style: AppTextStyle.subtitle.copyWith(
                        color: AppColor.main,
                      ),
                    ),
                  ),
                  body: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          BlocProvider.of<PlaceMapBloc>(context).add(
                            RemoveInfoWidgetPlaceMapEvent(),
                          );
                        },
                        child: DecoratedBox(
                          decoration: const BoxDecoration(color: AppColor.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                            child: FindPlaceTextFieldWidget(
                              data: state.data,
                              callback: (
                                selectedCategories,
                                rangeValues,
                                sortedPlaces,
                              ) {
                                BlocProvider.of<PlaceMapBloc>(context).add(
                                  ChanceValuesPlaceMapEvent(
                                    sortedPlaces,
                                    rangeValues,
                                    selectedCategories,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            YandexMap(
                              onMapTap: (Point point) {
                                if (state.selectedPlaceScreenData != null) {
                                  BlocProvider.of<PlaceMapBloc>(context).add(
                                    RemoveInfoWidgetPlaceMapEvent(),
                                  );
                                }
                              },
                              key: mapKey,
                              mapObjects: mapsObject,
                              onMapCreated: (YandexMapController yandexMapController) async {
                                final placemarkMapObject = mapsObject.firstWhere((el) => el.mapId == cameraMapObjectId);
                                controller = yandexMapController;
                                await controller.moveCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(target: placemarkMapObject.point, zoom: 11),
                                  ),
                                );
                              },
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<PlaceMapBloc>(context).add(
                                          UpdatePlaceMapEvent(),
                                        );
                                      },
                                      child: SvgPicture.asset(AppImages.refresh),
                                    ),
                                    state.selectedPlaceScreenData != null
                                        ? const SizedBox()
                                        : AddNewPlaceButtonWidget(onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => const AddNewPlaceScreen(),
                                              ),
                                            );
                                          }),
                                    InkWell(
                                      onTap: () async {
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
                                state.selectedPlaceScreenData != null
                                    ? Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: SizedBox(
                                            height: 170,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: PlaceWidget(places: state.selectedPlaceScreenData!),
                                            )),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
