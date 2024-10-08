import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FilterssNotifier extends StateNotifier< Map<dynamic, bool>> {
  FilterssNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false,
        });

  // -- > craete function emulate the toogleMealFilters in tabes Screen
  void setFilters( Map<dynamic, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterssProvider =
    StateNotifierProvider<FilterssNotifier, Map<dynamic, bool>>(
  (ref) => FilterssNotifier(),
);

final FilteredMealsProvider = Provider(
  (ref) {
    final meals = ref.watch(mealsProvider);
    final Map<dynamic, bool> activeFilters = ref.watch(filterssProvider);

    return meals.where(
      (meal) {
        if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }

        return true;
      },
    ).toList();
  },
);
