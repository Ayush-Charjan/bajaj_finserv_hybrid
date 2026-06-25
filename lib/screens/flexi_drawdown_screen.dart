import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class FlexiDrawdownScreen extends StatefulWidget {
  const FlexiDrawdownScreen({Key? key}) : super(key: key);

  @override
  State<FlexiDrawdownScreen> createState() => _FlexiDrawdownScreenState();
}

class _FlexiDrawdownScreenState extends State<FlexiDrawdownScreen> {
  final _amountController = TextEditingController();
  double _availableLimit = 350000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Drawdown Funds', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter Drawdown Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Available to withdraw: ₹${_availableLimit.toStringAsFixed(0)}', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
            const SizedBox(height: 24),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary),
              decoration: InputDecoration(
                prefixText: '₹ ',
                hintText: '0',
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary, width: 2)),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Select Bank Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.account_balance, color: AppColors.primary),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('HDFC BANK - XXXX1234', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('Savings Account', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                   _showSuccess();
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: const Text('WITHDRAW FUNDS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Funds will be credited to your bank account within 2 hours.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccess() {
    final amount = _amountController.text.isEmpty ? '0' : _amountController.text;
    final transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const SizedBox(height: 16),
            const Text('Withdrawal Successful', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('₹$amount', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 24),
            const Divider(),
            _buildReceiptRow('Transaction ID', transactionId),
            _buildReceiptRow('Date', '24 Aug 2025, 02:30 PM'),
            _buildReceiptRow('Sent to', 'HDFC Bank - XXXX1234'),
            _buildReceiptRow('Status', 'Success', valueColor: Colors.green),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('SHARE'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context); // Back to dashboard
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('DONE', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: valueColor ?? Colors.black)),
        ],
      ),
    );
  }
}
