import 'package:interesting_places/presentation/enum/enum.dart';

class FilterScreenData {
  final List<CategoryType> selectedCategories;

  FilterScreenData(this.selectedCategories);

  static FilterScreenData init() => FilterScreenData([]);

  FilterScreenData copyWith({
    List<CategoryType>? selectedCategories,
  }) =>
      FilterScreenData(
        selectedCategories ?? this.selectedCategories,
      );
}
