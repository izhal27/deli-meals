import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoriteMeals;

  FavoritesPage(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Center(
          child: Text('You have no Favoritess yet - start adding some!'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final currentMeal = favoriteMeals[index];

          return MealItem(
            id: currentMeal.id,
            title: currentMeal.title,
            imageUrl: currentMeal.imageUrl,
            duration: currentMeal.duration,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
