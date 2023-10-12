import 'dart:typed_data';

class PlaceScreenData {
  final List<Uint8List> photo;
  final String category;
  final String name;
  final String latitude;
  final String longitude;
  final String description;
  final double distance;

  PlaceScreenData(
    this.photo,
    this.category,
    this.name,
    this.latitude,
    this.longitude,
    this.description,
    this.distance,
  );

  static PlaceScreenData init() => PlaceScreenData(
        [],
        '',
        '',
        '',
        '',
        '',
        0,
      );

  PlaceScreenData copyWith({
    List<Uint8List>? photo,
    String? category,
    String? name,
    String? latitude,
    String? longitude,
    String? description,
    double? distance,
  }) =>
      PlaceScreenData(
        photo ?? this.photo,
        category ?? this.category,
        name ?? this.name,
        latitude ?? this.latitude,
        longitude ?? this.longitude,
        description ?? this.description,
        distance ?? this.distance,
      );
}
