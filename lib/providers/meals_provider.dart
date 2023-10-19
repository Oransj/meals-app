import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_app/data/dummy_data.dart";

/// The meals provider. Returns [dummyMeals] as the value.
final mealsProvider = Provider((ref) {
  return dummyMeals;
});

