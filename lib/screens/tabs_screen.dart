import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/components/main_drawer.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/providers/favorites_provider.dart';
import 'package:mealapp/providers/filters_provider.dart';
import 'package:mealapp/providers/nav_bar_provider.dart';
import 'package:mealapp/screens/categories_screen.dart';
import 'package:mealapp/screens/filters_screens.dart';
import 'package:mealapp/screens/meals_screens.dart';

class TabsScreen extends ConsumerWidget {
  // THIRD STEP >>>
  const TabsScreen({super.key});

  // List of widgets to display based on the selected index

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FOURTH STEP >>>
    //ref.read(provider) for read the value
    // ref.watch(provider) for read the value and change the valuuee then is best usage
    final List<Meal> availablrMeals = ref.watch(FilteredMealsProvider);
    final List<Meal> fovoriteMeal = ref.watch(favoritesMealsProvider);
    final int selectedPageIndex = ref.watch(navBarProvider);

    final List<Widget> pages = [
      CategoriesScreen(
        availablrMeals: availablrMeals,
      ),
      MealsScreens(
        meals: fovoriteMeal,
      ), // Make sure you have a FavoritesScreen widget
    ];

    void _setScreen(String identifier) {
      Navigator.of(context).pop();
      if (identifier == 'filters') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const FiltersScreens(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text(selectedPageIndex == 0 ? "Pick your category" : "Favorites"),
      ),
      body: pages[selectedPageIndex],
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ref.read(navBarProvider.notifier).selectPage,
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_outlined), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_rounded), label: "Favorites"),
        ],
      ),
    );
  }
}
