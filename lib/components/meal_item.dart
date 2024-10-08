import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });
  final Meal meal;

  List<dynamic> get complexityText {
    switch (meal.complexity) {
      case Complexity.simple:
        return ["Simple", Icons.battery_1_bar];
      case Complexity.challenging:
        return ["Challenging", Icons.battery_3_bar];
      case Complexity.hard:
        return ["Hard", Icons.battery_full];
      //default:return ['Unknown', Icons.error];
    }
  }

  List<dynamic> get affordability {
    switch (meal.affordability) {
      case Affordability.affordable:
        return ["Affordable", Icons.attach_money];
      case Affordability.pricey:
        return ["Pricey", Icons.money];
      case Affordability.luxurious:
        return ["Luxurious", Icons.euro_symbol];
      //default: return ['Unknown', Icons.error];
    }
  }

  final void Function(Meal meal) onSelectMeal;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge, // depend on above properties,
      elevation: 2,
      child: InkWell(
        onTap: () => onSelectMeal(meal),
        child: Column(
          children: [
            Stack(
              children: [
                //Interstinng -->>>>
                Hero(
                  tag: meal.id,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(meal.imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 30,
                    ),
                    color: Colors.black54,
                    child: Column(
                      children: [
                        Text(
                          meal.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow
                              .ellipsis, // if happen the text over 2 line will add ....
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.schedule),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "${meal.duration} min",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(complexityText[1]),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "${complexityText[0]}",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(affordability[1]),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    "${affordability[0]}",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
