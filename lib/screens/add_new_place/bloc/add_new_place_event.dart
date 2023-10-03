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