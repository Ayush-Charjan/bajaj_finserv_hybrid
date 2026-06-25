import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

import 'flexi_drawdown_screen.dart';

class FlexiServiceDeliveryScreen extends StatelessWidget {
  const FlexiServiceDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildLimitCard(),
            _buildQuickActions(context),
            _buildSectionHeader('Transaction History'),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              const Text(
                'Flexi Loan Service',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Loan Account: BL402P5P727390',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, -16, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Available Limit', style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text('Total Limit: ₹5,00,000', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Text('₹', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
              SizedBox(width: 4),
              Text('3,50,000', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Utilized: ₹1,50,000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Text('70% Available', style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildActionItem(Icons.file_upload_outlined, 'Drawdown', Colors.blue, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FlexiDrawdownScreen()));
          }),
          _buildActionItem(Icons.file_download_outlined, 'Part-pay', Colors.orange, () {}),
          _buildActionItem(Icons.info_outline, 'Statements', Colors.teal, () {}),
          _buildActionItem(Icons.cancel_outlined, 'Foreclose', Colors.red, () {}),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    final transactions = [
      {'title': 'Drawdown Request', 'date': '24 Aug 2025', 'amount': '+ ₹50,000', 'status': 'Successful', 'color': Colors.green},
      {'title': 'Part-payment', 'date': '15 Aug 2025', 'amount': '- ₹20,000', 'status': 'Successful', 'color': Colors.blue},
      {'title': 'EMI Payment', 'date': '05 Aug 2025', 'amount': '- ₹14,446', 'status': 'Successful', 'color': Colors.blue},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: transactions.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            title: Text(tx['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle: Text(tx['date'] as String, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tx['amount'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: tx['amount'].toString().contains('+') ? Colors.green : Colors.black)),
                Text(tx['status'] as String, style: TextStyle(fontSize: 10, color: tx['color'] as Color)),
              ],
            ),
          );
        },
      ),
    );
  }
}
