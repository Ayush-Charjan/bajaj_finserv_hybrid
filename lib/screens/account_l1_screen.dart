import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'account_l2_screen.dart';

class AccountL1Screen extends StatelessWidget {
  const AccountL1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Your Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('View all', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _buildActionChip('MANAGE YOUR PROFILE', () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountL2Screen()));
                  }),
                  const SizedBox(width: 8),
                  _buildActionChip('MANAGE YOUR BANK ACCOUNT', () {}),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionHeader('Our recommendations'),
            _buildRecommendationGrid(),
            const SizedBox(height: 20),
            _buildSectionHeader('Know your services'),
            _buildServicesHorizontalList(),
            const SizedBox(height: 20),
            _buildSectionHeader('Explore'),
            _buildExploreGrid(),
            const SizedBox(height: 20),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.accent),
                label: const Text('View more', style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.orange.shade100),
        ),
        child: Text(
          label,
          style: const TextStyle(color: AppColors.accent, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
      ),
    );
  }

  Widget _buildRecommendationGrid() {
    final items = [
      {'title': 'Personal Loan', 'image': 'assets/images/personal_loan.jpg'},
      {'title': 'Insta EMI Card', 'image': 'assets/images/ac_emi.jpg'},
      {'title': 'Fixed Deposit', 'image': 'assets/images/stock_market.png'},
      {'title': 'Loan Against Securities', 'image': 'assets/images/business_loan.jpg'},
      {'title': 'Business Loan', 'image': 'assets/images/business_loan.jpg'},
      {'title': 'Home Loan', 'image': 'assets/images/home_loan.jpg'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(items[index]['image']!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              items[index]['title']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
    );
  }

  Widget _buildServicesHorizontalList() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset('assets/images/banner${index + 1}.jpg', height: 120, width: 120, fit: BoxFit.cover),
                    ),
                    const Icon(Icons.play_circle_fill, color: Colors.orange, size: 32),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  index == 0 ? 'How to view your loan details?' : index == 1 ? 'How to view your loan details?' : 'How to update your profile details?',
                  style: const TextStyle(fontSize: 10),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExploreGrid() {
    final items = [
      {'title': 'Bajaj Pay', 'icon': Icons.account_balance_wallet, 'color': Colors.blue},
      {'title': 'Locate us', 'icon': Icons.location_on, 'color': Colors.red},
      {'title': 'Fun zone', 'icon': Icons.videogame_asset, 'color': Colors.purple},
      {'title': 'Help and support', 'icon': Icons.help_outline, 'color': Colors.teal},
      {'title': 'Bajaj Prime', 'icon': Icons.star, 'color': Colors.amber},
      {'title': 'Do not call', 'icon': Icons.phone_disabled, 'color': Colors.orange},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[index]['icon'] as IconData, color: items[index]['color'] as Color, size: 32),
              const SizedBox(height: 8),
              Text(
                items[index]['title'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
