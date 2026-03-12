// Reusable EMI card widget
import 'package:flutter/material.dart';
import '../models/emi.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';

class EmiCardWidget extends StatelessWidget {
  final EMI emi;
  final VoidCallback? onPayNow;

  const EmiCardWidget({
    Key? key,
    required this.emi,
    this.onPayNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate days until due
    int daysUntilDue = emi.dueDate.difference(DateTime.now()).inDays;

    // Determine urgency color
    Color urgencyColor = daysUntilDue <= 3
        ? Colors.red
        : daysUntilDue <= 7
            ? Colors.orange
            : Colors.green;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loan type and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    emi.loanType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                if (emi.isPaid)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'PAID',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // EMI amount
            Row(
              children: [
                Icon(Icons.currency_rupee,
                    size: 20, color: Colors.blue.shade700),
                Text(
                  emi.emiAmount.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Due date
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: urgencyColor),
                const SizedBox(width: 4),
                Text(
                  'Due: ${DateFormat('dd MMM yyyy').format(emi.dueDate)}',
                  style: TextStyle(
                    color: urgencyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '($daysUntilDue days left)',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Remaining EMIs
            Text(
              '${emi.remainingEmis} EMIs remaining',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            // Pay now button (if not paid)
            if (!emi.isPaid && onPayNow != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPayNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Pay Now'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
