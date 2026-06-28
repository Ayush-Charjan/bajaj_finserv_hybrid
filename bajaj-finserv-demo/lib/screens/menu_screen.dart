// Menu Screen
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MenuScreen extends StatelessWidget {
  final bool isEmbedded;
  final bool useNativeShell;

  const MenuScreen(
      {Key? key, this.isEmbedded = false, this.useNativeShell = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: (isEmbedded || useNativeShell)
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              leading: const SizedBox.shrink(),
              leadingWidth: 0,
              backgroundColor: AppColors.primary,
              title: const Text('Menu', style: TextStyle(color: Colors.white)),
            ),
      body: ListView(
        children: [
          _buildMenuSection(
            'Financial Services',
            [
              {
                'icon': Icons.account_balance,
                'title': 'All Loans',
                'subtitle': 'View all loan products'
              },
              {
                'icon': Icons.credit_card,
                'title': 'Credit Cards',
                'subtitle': 'Apply for credit cards'
              },
              {
                'icon': Icons.assessment,
                'title': 'Credit Score',
                'subtitle': 'Check your credit score'
              },
              {
                'icon': Icons.account_balance_wallet,
                'title': 'Insurance',
                'subtitle': 'Life & health insurance'
              },
              {
                'icon': Icons.trending_up,
                'title': 'Investments',
                'subtitle': 'Mutual funds & stocks'
              },
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            'Pay & Recharge',
            [
              {
                'icon': Icons.phone_android,
                'title': 'Mobile Recharge',
                'subtitle': 'Prepaid & postpaid'
              },
              {
                'icon': Icons.tv,
                'title': 'DTH Recharge',
                'subtitle': 'Recharge DTH connection'
              },
              {
                'icon': Icons.flash_on,
                'title': 'Electricity Bill',
                'subtitle': 'Pay electricity bills'
              },
              {
                'icon': Icons.water_drop,
                'title': 'Water Bill',
                'subtitle': 'Pay water bills'
              },
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            'Account & Settings',
            [
              {
                'icon': Icons.person,
                'title': 'My Profile',
                'subtitle': 'View and edit profile'
              },
              {
                'icon': Icons.history,
                'title': 'Transaction History',
                'subtitle': 'All your transactions'
              },
              {
                'icon': Icons.notifications,
                'title': 'Notifications',
                'subtitle': 'Manage notifications'
              },
              {
                'icon': Icons.settings,
                'title': 'Settings',
                'subtitle': 'App preferences'
              },
            ],
          ),
          const Divider(height: 1),
          _buildMenuSection(
            'Help & Support',
            [
              {
                'icon': Icons.help_outline,
                'title': 'Help Center',
                'subtitle': 'FAQs and support'
              },
              {
                'icon': Icons.chat_bubble_outline,
                'title': 'Chat Support',
                'subtitle': '24/7 customer support'
              },
              {
                'icon': Icons.star_outline,
                'title': 'Rate Us',
                'subtitle': 'Share your feedback'
              },
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ...items
            .map((item) => ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(item['icon'], color: AppColors.primary),
                  ),
                  title: Text(
                    item['title'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(item['subtitle'],
                      style: const TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {},
                ))
            .toList(),
      ],
    );
  }
}
