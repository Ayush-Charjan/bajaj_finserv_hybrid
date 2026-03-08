// FeatureItem model for home screen feature grid
import 'package:flutter/material.dart';

class FeatureItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  FeatureItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
