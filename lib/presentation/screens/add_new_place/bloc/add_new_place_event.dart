part of 'add_new_place_bloc.dart';

@immutable
abstract class AddNewPlaceEvent {}

class LoadAddNewPlaceEvent extends AddNewPlaceEvent {}

class AddPhotoForNewPlaceEvent extends AddNewPlaceEvent {
  final Uint8List photo;

  AddPhotoForNewPlaceEvent(this.photo);
}

class RemovePhotoForNewPlaceEvent extends AddNewPlaceEvent {
  final int index;

  RemovePhotoForNewPlaceEvent(this.index);
}

class AddCategoryForNewPlaceEvent extends AddNewPlaceEvent {
  final String category;

  AddCategoryForNewPlaceEvent(this.category);
}

class SaveIndexForNewPlaceEvent extends AddNewPlaceEvent {
  final int index;

  SaveIndexForNewPlaceEvent(this.index);
}

class SaveNameForNewPlaceEvent extends AddNewPlaceEvent {
  final String name;

  SaveNameForNewPlaceEvent(this.name);
}

class SaveLatitudeForNewPlaceEvent extends AddNewPlaceEvent {
  final String latitude;

  SaveLatitudeForNewPlaceEvent(this.latitude);
}

class SaveLongitudeForNewPlaceEvent extends AddNewPlaceEvent {
  final String longitude;

  SaveLongitudeForNewPlaceEvent(this.longitude);
}

class SaveDescriptionForNewPlaceEvent extends AddNewPlaceEvent {
  final String description;

  SaveDescriptionForNewPlaceEvent(this.description);
}

class CreateNewPlaceEvent extends AddNewPlaceEvent {}
