import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interesting_places/presentation/screens/add_new_place/bloc/add_new_place_bloc.dart';
import 'package:interesting_places/presentation/utils/app_images.dart';
class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.photo,
    required this.bloc,
    required this.index,
  });

  final AddNewPlaceBloc bloc;
  final Uint8List photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            height: 72,
            width: 72,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.memory(
                photo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              bloc.add(RemovePhotoForNewPlaceEvent(index));
            },
            child: SvgPicture.asset(AppImages.clear),
          ),
        ],
      ),
    );
  }
}
