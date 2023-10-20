import 'package:flutter/material.dart';

/// Model for a category.
class Category {
  const Category(
      {required this.id, required this.title, this.color = Colors.orange});

  final String id;
  final String title;
  final Color color;
}
