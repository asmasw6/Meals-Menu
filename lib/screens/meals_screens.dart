import 'package:flutter/material.dart';
import 'package:mealapp/components/meal_item.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meal_details_screen.dart';

class MealsScreens extends StatelessWidget {
  const MealsScreens({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return title == null
        ? content(context)
        : Scaffold(
            appBar: AppBar(
              title: Text(title!),
            ),
            body: content(context),
          );
  }

  SingleChildScrollView content(BuildContext context)  {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map(
              (meal) => MealItem(
                onSelectMeal: (meal) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealDetailsScreen(
                      meal: meal,
                      onToggleFavorite: onToggleFavorite,
                    ),
                  ),
                ),
                meal: meal,
              ),
            )
            .toList(),
      ),
    );
  }


}

