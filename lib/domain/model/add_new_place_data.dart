

import 'package:flutter/foundation.dart';

class AddNewPlaceData {
  final List<Uint8List>? photo;
  final String? category;
  final String? name;
  final String? latitude;
  final String? longitude;
  final String? description;

  AddNewPlaceData({
    this.photo,
    this.category,
    this.name,
    this.latitude,
    this.longitude,
    this.description,
  });
}
