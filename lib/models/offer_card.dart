// Offer card model for promotional offers
import 'package:flutter/material.dart';

class OfferCard {
  final String id;
  final String title;
  final String subtitle;
  final String buttonText;
  final Gradient? gradient;
  final Color backgroundColor;
  final String? imageUrl;

  OfferCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.gradient,
    this.backgroundColor = const Color.fromARGB(255, 248, 149, 56),
    this.imageUrl,
  });
}
