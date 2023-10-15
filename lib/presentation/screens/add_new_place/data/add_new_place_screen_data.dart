import 'dart:typed_data';

class AddNewPlaceScreenData {
  final List<Uint8List> photo;
  final String category;
  final int index;
  final String name;
  final String latitude;
  final String longitude;
  final String description;

  AddNewPlaceScreenData(
    this.photo,
    this.category,
    this.index,
    this.name,
    this.latitude,
    this.longitude,
    this.description,
  );

  static AddNewPlaceScreenData init() => AddNewPlaceScreenData(
        [],
        '',
        -1,
        '',
        '',
        '',
        '',
      );

  AddNewPlaceScreenData copyWith({
    List<Uint8List>? photo,
    String? category,
    int? index,
    String? name,
    String? latitude,
    String? longitude,
    String? description,
  }) =>
      AddNewPlaceScreenData(
        photo ?? this.photo,
        category ?? this.category,
        index ?? this.index,
        name ?? this.name,
        latitude ?? this.latitude,
        longitude ?? this.longitude,
        description ?? this.description,
      );
}
