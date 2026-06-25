import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class YourRelationsScreen extends StatelessWidget {
  const YourRelationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Your relations', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildRelationCard(),
            _buildRelationCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                      child: const Text('Active', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const Text('₹1,20,000', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('SAMSUNG 32-Inch Class Ful...', style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('BL402P5P727390', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRelationAction(Icons.payment, 'Make payment'),
                    _buildRelationAction(Icons.description_outlined, 'Statement'),
                    _buildRelationAction(Icons.grid_view, 'More'),
                    _buildRelationAction(Icons.chevron_right, 'Details'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8))),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Instalment of ₹14,446 due on 5 Sep 2025', style: TextStyle(fontSize: 11)),
                ),
                TextButton(onPressed: () {}, child: const Text('Pay now', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 11))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelationAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue.shade100)),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}

class LoanPaymentsScreen extends StatelessWidget {
  const LoanPaymentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Loan payments', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildLoanPaymentsGrid(),
    );
  }

  Widget _buildLoanPaymentsGrid() {
    final items = [
      {'title': 'Advance EMI', 'icon': Icons.fast_forward_outlined, 'color': Colors.blue},
      {'title': 'Part prepayment', 'icon': Icons.account_balance_wallet_outlined, 'color': Colors.teal},
      {'title': 'Overdue EMI', 'icon': Icons.add_to_photos_outlined, 'color': Colors.blue},
      {'title': 'Foreclosure', 'icon': Icons.refresh_rounded, 'color': Colors.cyan},
      {'title': 'Upcoming EMI', 'icon': Icons.percent_rounded, 'color': Colors.indigo},
      {'title': 'Gold loan interest', 'icon': Icons.account_balance_outlined, 'color': Colors.cyan},
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: (items[index]['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[index]['icon'] as IconData, color: items[index]['color'] as Color, size: 28),
              const SizedBox(height: 8),
              Text(
                items[index]['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Statements and documents', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _buildDocumentsGrid(),
    );
  }

  Widget _buildDocumentsGrid() {
    final items = [
      {'title': 'Statement of account', 'icon': Icons.file_download_outlined},
      {'title': 'NOC/NDC', 'icon': Icons.description_outlined},
      {'title': 'Repayment schedule', 'icon': Icons.account_balance},
      {'title': 'Agreement', 'icon': Icons.description},
      {'title': 'Interest certificate', 'icon': Icons.card_membership},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(items[index]['icon'] as IconData, color: AppColors.primary),
          title: Text(items[index]['title'] as String, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.chevron_right, size: 16),
          onTap: () {},
        );
      },
    );
  }
}

class YourAccountDetailsScreen extends StatelessWidget {
  const YourAccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Your Account', style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOptionTile('Profile details', Icons.person_outline),
          _buildOptionTile('Bank accounts', Icons.account_balance_outlined),
          _buildOptionTile('Saved cards', Icons.credit_card_outlined),
          _buildOptionTile('Settings', Icons.settings_outlined),
          _buildOptionTile('Logout', Icons.logout, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String title, IconData icon, {bool isDestructive = false}) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.primary),
        title: Text(title, style: TextStyle(color: isDestructive ? Colors.red : Colors.black, fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () {},
      ),
    );
  }
}
