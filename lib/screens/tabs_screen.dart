import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/categories_screen.dart';
import 'package:mealapp/screens/meals_screens.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _fovoriteMeal = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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
    final List<Widget> _pages = [
      CategoriesScreen(
        onToggleFavorite: _toggleMealFavoritesStatus,
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
