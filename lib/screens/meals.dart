import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_information.dart';
import 'package:meals_app/widgets/meal_item.dart';

/// Shows a list of meals.
class MealsScreen extends StatelessWidget {
  const MealsScreen(this.meals, {super.key, this.title});

  final String? title;
  final List<Meal> meals;

  /// Selects a meal and navigates to the meal information screen.
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealInformationScreen(
              meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder( //Uses ListView.builder since the list of meals can be long
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (Meal meal) {
          selectMeal(context, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nothing here!",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try selecting a different category",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: body,
    );
  }
}
