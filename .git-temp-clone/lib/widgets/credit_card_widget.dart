// Reusable credit card widget for home screen
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CreditCardWidget extends StatelessWidget {
  final double creditLimit;
  final double availableCredit;

  const CreditCardWidget({
    Key? key,
    required this.creditLimit,
    required this.availableCredit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double usedCredit = creditLimit - availableCredit;
    double usagePercentage = (usedCredit / creditLimit) * 100;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bajaj Finserv Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.credit_card,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Available credit
          const Text(
            'Available Credit',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '₹${availableCredit.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Progress bar
          LinearProgressIndicator(
            value: usagePercentage / 100,
            backgroundColor: Colors.white30,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
          const SizedBox(height: 8),

          // Credit limit info
          Text(
            'Credit Limit: ₹${creditLimit.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
