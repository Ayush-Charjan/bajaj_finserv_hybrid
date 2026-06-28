import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AccountL3Screen extends StatelessWidget {
  final String? initialSection;
  const AccountL3Screen({Key? key, this.initialSection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Services', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildServicesForYou(),
            const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
            _buildSectionHeader('Statements and documents'),
            _buildDocumentsGrid(),
            const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
            _buildSectionHeader('Recommended Products', showViewAll: true),
            _buildRecommendedProducts(),
            const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
            _buildSectionHeader('Loan payments'),
            _buildLoanPaymentsGrid(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
          if (showViewAll)
            const Text('View all', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildServicesForYou() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text('Services for you', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red.shade400, Colors.red.shade600]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('VIEW YOUR STATEMENT OF ACCOUNT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(height: 8),
                          const Text('• Explore common queries\n• Review transaction history', style: TextStyle(color: Colors.white, fontSize: 10)),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero),
                            child: const Text('View Now', style: TextStyle(fontSize: 10, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.person, size: 80, color: Colors.white24),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDocumentsGrid() {
    final items = [
      {'title': 'Statement of account', 'icon': Icons.file_download_outlined},
      {'title': 'NOC/NDC', 'icon': Icons.description_outlined},
      {'title': 'Repayment schedule', 'icon': Icons.account_balance},
      {'title': 'Agreement', 'icon': Icons.description},
      {'title': 'Interest certificate', 'icon': Icons.card_membership},
      {'title': 'View all documents', 'icon': Icons.chevron_right, 'isCircle': false},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        bool isArrow = items[index]['title'] == 'View all documents';
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isArrow ? Colors.blue.shade50 : Colors.white,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(items[index]['icon'] as IconData, color: isArrow ? Colors.blue : AppColors.primary, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              items[index]['title'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecommendedProducts() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: index == 0 ? Colors.pink.shade50 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: index == 0 ? Colors.pink.shade100 : Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pre-approved Personal Loan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const Text('Approved loan offer amount', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.grey.shade300)),
                        child: const Text('Apply Now', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Center(child: Icon(Icons.person, size: 80, color: Colors.black12)),
              ],
            ),
          );
        },
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
              Icon(items[index]['icon'] as IconData, color: items[index]['color'] as Color, size: 30),
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
