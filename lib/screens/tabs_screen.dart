import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mealapp/components/main_drawer.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/categories_screen.dart';
import 'package:mealapp/screens/filters_screens.dart';
import 'package:mealapp/screens/meals_screens.dart';

const kInintialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _fovoriteMeal = [];
  Map<Filter, bool> _selectedFilters = kInintialFilter;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context)
          .push(
            MaterialPageRoute(
              builder: (context) =>  FiltersScreens(
                currentFilters:_selectedFilters,
              ),
            ),
          )
          .then((result) => setState(
                () => _selectedFilters = result ?? kInintialFilter,
              ));
    }
  }

  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = _fovoriteMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _fovoriteMeal.remove(meal);
        _showInfoMessage("Mealis no longer a favorite.");
      });
    } else {
      setState(() {
        _fovoriteMeal.add(meal);
        _showInfoMessage("Marked as a favorite!");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  // List of widgets to display based on the selected index

  @override
  Widget build(BuildContext context) {
    final List<Meal> availablrMeals = dummyMeals.where(
      (meal) {
        if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }

        return true;
      },
    ).toList();
    final List<Widget> _pages = [
      CategoriesScreen(
        onToggleFavorite: _toggleMealFavoritesStatus,
        availablrMeals: availablrMeals,
      ),
      MealsScreens(
        meals: _fovoriteMeal,
        onToggleFavorite: _toggleMealFavoritesStatus,
      ), // Make sure you have a FavoritesScreen widget
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            Text(_selectedPageIndex == 0 ? "Pick your category" : "Favorites"),
      ),
      body: _pages[_selectedPageIndex],
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
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
