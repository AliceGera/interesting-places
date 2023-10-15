import 'package:interesting_places/presentation/utils/app_images.dart';

enum CategoryType {
  hotel,
  restaurant,
  particularPlace,
  park,
  museum,
  cafe;

  String getCategoryTypeTitle() {
    switch (this) {
      case CategoryType.hotel:
        return 'Отель';
      case CategoryType.restaurant:
        return 'Ресторан';
      case CategoryType.particularPlace:
        return 'Особое место';
      case CategoryType.park:
        return 'Парк';
      case CategoryType.museum:
        return 'Музей';
      case CategoryType.cafe:
        return 'Кафе';
    }
  }
  String getCategoryTypeImage() {
    switch (this) {
      case CategoryType.hotel:
        return AppImages.hotel;
      case CategoryType.restaurant:
        return AppImages.restaurant;
      case CategoryType.particularPlace:
        return AppImages.particularPlace;
      case CategoryType.park:
        return AppImages.park;
      case CategoryType.museum:
        return AppImages.museum;
      case CategoryType.cafe:
        return AppImages.cafe;
    }
  }
}
