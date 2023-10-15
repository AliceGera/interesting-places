part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}
class LoadFilterEvent extends FilterEvent {}
class UpdateSelectedCategoriesListEvent extends FilterEvent {
  final CategoryType category;

  UpdateSelectedCategoriesListEvent(this.category);
}
class CleanSelectedCategoriesListEvent extends FilterEvent {

  CleanSelectedCategoriesListEvent();
}