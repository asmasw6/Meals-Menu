import 'package:flutter/material.dart';
import 'package:mealapp/components/meal_item.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meal_details_screen.dart';

class MealsScreens extends StatelessWidget {
  const MealsScreens({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

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

