import 'package:flutter/material.dart';
import 'package:mealapp/components/category_grid_item.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availablrMeals,
  });
  final List<Meal> availablrMeals;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 5 / 7,
      ),
      children: [
        for (final item in availableCategories)
          CategoryGridItem(
            category: item,
            availablrMeals: availablrMeals,

          )
      ],
    );
  }
}
