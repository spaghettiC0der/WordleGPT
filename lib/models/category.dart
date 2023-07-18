import 'package:flutter/material.dart';

class Category {
  final String id;
  final IconData iconData;
  final String title;
  int total;
  int solved;
  Category({
    required this.id,
    required this.iconData,
    required this.title,
    this.total = 10,
    this.solved = 0,
  });
}
