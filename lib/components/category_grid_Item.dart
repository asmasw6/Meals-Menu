import 'package:flutter/material.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/category.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meals_screens.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onToggleFavorite,
  });
  final Category category;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //GestureDetector
      onTap: () {
        final List<Meal> filterMeal = dummyMeals
            .where(
              (meal) => meal.categories.contains(category.id),
            )
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MealsScreens(
              title: category.title,
              meals: filterMeal, onToggleFavorite: onToggleFavorite,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha((255 * .54).toInt()),
              category.color.withAlpha((255 * .9).toInt()),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
