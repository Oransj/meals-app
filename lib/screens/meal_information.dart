import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/widgets/checkable_step.dart';

/// The screen that shows the information of a meal.
/// In this case a summary, the ingredients and the steps.
/// Is ConsumerWidget because it uses the [favoriteMealsProvider].
class MealInformationScreen extends ConsumerWidget {
  const MealInformationScreen(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(
        favoriteMealsProvider); //Gets the favorite meals from the provider

    final isFavorite = meals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final added = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavorite(meal);
              ScaffoldMessenger.of(context)
                  .clearSnackBars(); //Clears all snackbars in case there is one already showing
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(added
                      ? "Meal added as favorite"
                      : "Meal removed from favorites"),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animaton) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animaton),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl, //Gets the image from the internet using the url
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ingredient in meal.ingredients)
              CheckableStep(text: ingredient),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(height: 14),
            Text(
              "Steps",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: CheckableStep(text: step),
              ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
