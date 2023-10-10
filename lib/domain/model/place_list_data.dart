

import 'package:flutter/foundation.dart';

class PlaceListData {
  final List<PlaceData>? places;

  PlaceListData({
    this.places,
  });
}

class PlaceData {
  final List<Uint8List>? photo;
  final String? category;
  final String? name;
  final String? latitude;
  final String? longitude;
  final String? description;

  PlaceData({
    this.photo,
    this.category,
    this.name,
    this.latitude,
    this.longitude,
    this.description,
  });
}
