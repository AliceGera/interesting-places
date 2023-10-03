import 'dart:typed_data';

class AddNewPlaceScreenData {
  final List<Uint8List> photo;

  AddNewPlaceScreenData(
    this.photo,
  );

  static AddNewPlaceScreenData init() => AddNewPlaceScreenData(
        [],
      );

  AddNewPlaceScreenData copyWith({
    List<Uint8List>? photo,
  }) =>
      AddNewPlaceScreenData(
        photo ?? this.photo,
      );
}
