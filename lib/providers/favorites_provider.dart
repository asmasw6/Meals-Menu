import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/models/meal.dart';

class FavoritesMealsNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifier() : super([]);
  // craete fuction emulate the toogleMealFavorite in tabes Screen

  bool toggleMealFavoritesStatus(Meal meal) {
    final isExisting = state.contains(meal);
    if (isExisting) {
      //state.remove(meal);
      state = state.where((element) => element.id != meal.id).toList();

      return false;
    } else {
      //state.add(meal);
      state = [...state, meal];
      return true;
      // state = [1 , 2 , 3] + meal = 4
      // [ [1,2,3] , 4]
      // ...state >>> [1 , 2 , 3, 4]
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifier, List<Meal>>(
  (ref) => FavoritesMealsNotifier(),
);
