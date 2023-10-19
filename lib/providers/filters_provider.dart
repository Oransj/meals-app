import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

/// The filters that can be applied to the meals.
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

/// The state of the filters notifier.
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          // The initial state of the notifier. Sets all filters to false.
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  /// Sets a filter to be active or not.
  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  /// Allows you to set multiple filters at once.
  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

/// The provider for the filters notifier.
final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

/// The provider for the filtered meals. Returns a [List] of [Meal] that match the filters.
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filterProvider);

  return meals.where(
    (meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    },
  ).toList();
});
