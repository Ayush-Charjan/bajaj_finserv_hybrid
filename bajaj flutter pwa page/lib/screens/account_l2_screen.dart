import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'account_l3_screen.dart';
import 'profile_screen.dart';

class AccountL2Screen extends StatelessWidget {
  const AccountL2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Icon(Icons.account_balance, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            const Text('FINSERV',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
                icon: const Icon(Icons.payment, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
                onPressed: () {}),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildNavigationGrid(context),
            _buildNocBanner(),
            _buildSectionHeader('Your relations', showViewAll: true),
            _buildRelationCard(),
            _buildTrackApplications(),
            _buildPickUpSection(),
            _buildSectionHeader('Reminders'),
            _buildReminderCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
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
        childAspectRatio: 2.5,
        children: [
          _buildNavButton('Your relations', Icons.people_outline, () {}),
          _buildNavButton('Loan payments', Icons.payment, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountL3Screen(
                        initialSection: 'Loan payments')));
          }),
          _buildNavButton(
              'Statements and\ndocuments', Icons.description_outlined, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccountL3Screen(
                        initialSection: 'Statements and documents')));
          }),
          _buildNavButton('Your Account', Icons.account_circle_outlined, () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, size: 18, color: AppColors.primary),
            // const SizedBox(width: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNocBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.file_download_outlined, color: AppColors.primary),
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
                    color: Colors.orange, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary)),
          if (showViewAll)
            TextButton(
              onPressed: () {},
              child: const Text('View all',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
        ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Text('Active',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Text('₹1,20,000',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('SAMSUNG 32-Inch Class Ful...',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text('BL402P5P727390',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRelationAction(Icons.payment, 'Make payment'),
                    _buildRelationAction(
                        Icons.description_outlined, 'Statement of account'),
                    _buildRelationAction(Icons.grid_view, 'More services'),
                    _buildRelationAction(Icons.chevron_right, 'View details'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(8))),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Instalment of ₹14,446 due on 5 Sep 2025',
                      style: TextStyle(fontSize: 11)),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text('Pay now',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 11))),
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
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.shade100)),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 60,
          child: Text(label,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 8)),
        ),
      ],
    );
  }

  Widget _buildTrackApplications() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: const Row(
        children: [
          Icon(Icons.business_center_outlined, color: AppColors.primary),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Track applications and orders',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(
                    'Check the status of your loan applications and other orders',
                    style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildPickUpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Pick up where you left off'),
        SizedBox(
          height: 100,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                width: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Withdrawal bank change',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                    const Text('Loan account number: PS602P5P846205',
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(4)),
                      child: const Center(
                          child: Text('RESUME',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReminderCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(4)),
            child: const Text('Overdue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.wb_sunny_outlined, color: Colors.red, size: 30),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Personal Loan',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Loan account number: 2340230239840960',
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount due',
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                  Text('₹14,446',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text('Pay now',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold))),
            ],
          ),
        ],
      ),
    );
  }
}
