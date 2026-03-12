// EMI type model for different loan categories
import 'package:flutter/material.dart';

class EmiType {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final double interestRate;
  final String? imagePath; // Image asset path

  EmiType({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.description,
    required this.interestRate,
    this.imagePath,
  });
}
