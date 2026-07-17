import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'profile_screen.dart';
import 'account_l2_details_screens.dart';
import 'flexi_service_delivery_screen.dart';

class AccountL1Screen extends StatelessWidget {
  const AccountL1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            _buildNavigationGrid(context),
            _buildNocBanner(),
            const SizedBox(height: 8),
            Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Our recommendations'),
                  _buildRecommendationGrid(),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Know your services'),
                  _buildServicesHorizontalList(),
                  const SizedBox(height: 20),
                  _buildSectionHeader('Services for you'),
                  _buildServicesForYou(context),
                  const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
                  _buildSectionHeader('Statements and documents'),
                  _buildDocumentsGrid(context),
                  const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
                  _buildSectionHeader('Recommended Products',
                      showViewAll: true),
                  _buildRecommendedProducts(),
                  const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
                  _buildSectionHeader('Loan payments'),
                  _buildLoanPaymentsGrid(context),
                  const Divider(thickness: 4, color: Color(0xFFF0F4F8)),
                  _buildSectionHeader('Explore'),
                  _buildExploreGrid(),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_down,
                          color: AppColors.accent),
                      label: const Text('View more',
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ProfileScreen(isEmbedded: true)));
            },
            child: const Row(
              children: [
                Text('View profile ',
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                Icon(Icons.chevron_right, color: Colors.white, size: 16),
              ],
            ),
          ),
          const Spacer(),
          const Icon(Icons.qr_code_scanner, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.8,
        children: [
          _buildNavButton('Your relations', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const YourRelationsScreen()));
          }),
          _buildNavButton('Loan payments', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoanPaymentsScreen()));
          }),
          _buildNavButton('Statements and\ndocuments', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DocumentsScreen()));
          }),
          _buildNavButton('Your Account', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const YourAccountDetailsScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildNocBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.file_download_outlined,
              color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Your loan is closed. Get your NOC.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Download',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primary),
          ),
          if (showViewAll)
            const Text('View all',
                style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecommendationGrid() {
    final items = [
      {'title': 'Personal Loan', 'image': 'assets/images/personal_loan.jpg'},
      {'title': 'Insta EMI Card', 'image': 'assets/images/ac_emi.jpg'},
      {'title': 'Fixed Deposit', 'image': 'assets/images/stock_market.png'},
      {
        'title': 'Loan Against Securities',
        'image': 'assets/images/business_loan.jpg'
      },
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
      height: 160,
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
                      child: Image.asset('assets/images/banner${index + 1}.jpg',
                          height: 100, width: 120, fit: BoxFit.cover),
                    ),
                    const Icon(Icons.play_circle_fill,
                        color: Colors.orange, size: 32),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  index == 0
                      ? 'How to view your loan details?'
                      : index == 1
                          ? 'How to view your loan details?'
                          : 'How to update your profile details?',
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

  Widget _buildServicesForYou(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 140,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 280,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.red.shade400, Colors.red.shade600]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('VIEW YOUR STATEMENT OF ACCOUNT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                          const SizedBox(height: 4),
                          const Text(
                              '• Explore common queries\n• Review transaction history',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 9)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const FlexiServiceDeliveryScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                minimumSize: Size.zero),
                            child: const Text('View Now',
                                style: TextStyle(
                                    fontSize: 9, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.person, size: 60, color: Colors.white24),
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

  Widget _buildDocumentsGrid(BuildContext context) {
    final items = [
      {'title': 'Statement of account', 'icon': Icons.file_download_outlined},
      {'title': 'NOC/NDC', 'icon': Icons.description_outlined},
      {'title': 'Repayment schedule', 'icon': Icons.account_balance},
      {'title': 'Agreement', 'icon': Icons.description},
      {'title': 'Interest certificate', 'icon': Icons.card_membership},
      {'title': 'View all documents', 'icon': Icons.chevron_right},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        bool isArrow = items[index]['title'] == 'View all documents';
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DocumentsScreen()));
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isArrow ? Colors.blue.shade50 : Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(items[index]['icon'] as IconData,
                    color: isArrow ? Colors.blue : AppColors.primary, size: 24),
              ),
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

  Widget _buildRecommendedProducts() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: index == 0 ? Colors.pink.shade50 : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color:
                      index == 0 ? Colors.pink.shade100 : Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pre-approved Personal Loan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11)),
                      const Text('Approved loan offer amount',
                          style: TextStyle(fontSize: 9, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300)),
                        child: const Text('Apply Now',
                            style: TextStyle(
                                fontSize: 9, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Center(
                    child: Icon(Icons.person, size: 60, color: Colors.black12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoanPaymentsGrid(BuildContext context) {
    final items = [
      {
        'title': 'Advance EMI',
        'icon': Icons.fast_forward_outlined,
        'color': Colors.blue
      },
      {
        'title': 'Part prepayment',
        'icon': Icons.account_balance_wallet_outlined,
        'color': Colors.teal
      },
      {
        'title': 'Overdue EMI',
        'icon': Icons.add_to_photos_outlined,
        'color': Colors.blue
      },
      {
        'title': 'Foreclosure',
        'icon': Icons.refresh_rounded,
        'color': Colors.cyan
      },
      {
        'title': 'Upcoming EMI',
        'icon': Icons.percent_rounded,
        'color': Colors.indigo
      },
      {
        'title': 'Gold loan interest',
        'icon': Icons.account_balance_outlined,
        'color': Colors.cyan
      },
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
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoanPaymentsScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: (items[index]['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(items[index]['icon'] as IconData,
                    color: items[index]['color'] as Color, size: 28),
                const SizedBox(height: 8),
                Text(
                  items[index]['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExploreGrid() {
    final items = [
      {
        'title': 'Bajaj Pay',
        'icon': Icons.account_balance_wallet,
        'color': Colors.blue
      },
      {'title': 'Locate us', 'icon': Icons.location_on, 'color': Colors.red},
      {
        'title': 'Fun zone',
        'icon': Icons.videogame_asset,
        'color': Colors.purple
      },
      {
        'title': 'Help and support',
        'icon': Icons.help_outline,
        'color': Colors.teal
      },
      {'title': 'Bajaj Prime', 'icon': Icons.star, 'color': Colors.amber},
      {
        'title': 'Do not call',
        'icon': Icons.phone_disabled,
        'color': Colors.orange
      },
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(items[index]['icon'] as IconData,
                  color: items[index]['color'] as Color, size: 28),
              const SizedBox(height: 8),
              Text(
                items[index]['title'] as String,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }
}
