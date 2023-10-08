import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interesting_places/screens/add_new_place/bloc/add_new_place_bloc.dart';
import 'package:interesting_places/screens/map/map_screen.dart';
import 'package:interesting_places/utils/app_color.dart';
import 'package:interesting_places/utils/app_text_style.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PointToMapWidget extends StatelessWidget {
  const PointToMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      canRequestFocus: false,
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MapScreen(),
          ),
        ).then((value) {
          if (value is CameraPosition) {
            BlocProvider.of<AddNewPlaceBloc>(context).add(
              SaveLatitudeForNewPlaceEvent(value.target.latitude.toString()),
            );
            BlocProvider.of<AddNewPlaceBloc>(context).add(
              SaveLongitudeForNewPlaceEvent(value.target.longitude.toString()),
            );
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 37,
        ),
        child: Text(
          'Указать на карте',
          style: AppTextStyle.subtitle.copyWith(
            color: AppColor.green,
          ),
        ),
      ),
    );
  }
}
