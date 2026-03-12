// Helper widget to display images with fallback
import 'package:flutter/material.dart';

class AssetImageWithFallback extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? iconColor;

  const AssetImageWithFallback({
    Key? key,
    required this.assetPath,
    required this.fallbackIcon,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to icon if image not found
        return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Icon(
            fallbackIcon,
            size: width * 0.5,
            color: iconColor ?? Colors.grey.shade400,
          ),
        );
      },
    );
  }
}

// Helper for circular logo with fallback
class LogoWithFallback extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color backgroundColor;

  const LogoWithFallback({
    Key? key,
    required this.assetPath,
    this.size = 80,
    this.backgroundColor = const Color(0xFF1565C0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.25),
        child: Image.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.account_balance,
              size: size * 0.5,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
