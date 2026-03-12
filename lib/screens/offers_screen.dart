import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../utils/app_colors.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offers = MockDataService.getOffers();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers & Deals'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured Banner
              Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '🎉 Festival Sale!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Get zero-cost EMI on all products',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                        ),
                        onPressed: () {},
                        child: const Text('Shop Now'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Categories
              const Text(
                'Offers By Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All Offers', Icons.local_offer, true),
                    _buildCategoryChip('Loans', Icons.account_balance, false),
                    _buildCategoryChip('EMI', Icons.credit_card, false),
                    _buildCategoryChip('Shopping', Icons.shopping_bag, false),
                    _buildCategoryChip('Bills', Icons.receipt, false),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Offers
              const Text(
                'Top Offers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...offers.map((offer) => Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: offer.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              offer.subtitle,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Limited Time Offer',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _showOfferDetails(context, offer);
                                  },
                                  child: Text(offer.buttonText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),

              const SizedBox(height: 16),

              // Additional Offers
              _buildOfferCard(
                'Electronics EMI',
                'Zero down payment on smartphones, laptops & more',
                'Up to 20% off',
                Icons.phone_android,
                Colors.blue,
              ),
              _buildOfferCard(
                'Travel Loan',
                'Plan your dream vacation with easy EMI',
                '0% interest',
                Icons.flight,
                Colors.orange,
              ),
              _buildOfferCard(
                'Wedding Loan',
                'Make your special day more special',
                'Up to ₹15 Lakh',
                Icons.celebration,
                Colors.pink,
              ),
              _buildOfferCard(
                'Medical Emergency',
                'Instant approval for medical expenses',
                'Quick disbursal',
                Icons.medical_services,
                Colors.red,
              ),
              _buildOfferCard(
                'Education Loan',
                'Invest in your future with low-interest loans',
                'Flexible tenure',
                Icons.school,
                Colors.purple,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isSelected ? AppColors.primary : Colors.grey.shade200,
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(
    String title,
    String description,
    String badge,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            badge,
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  void _showOfferDetails(BuildContext context, dynamic offer) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              offer.subtitle,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Terms & Conditions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Offer valid for limited time'),
            const Text('• Subject to credit approval'),
            const Text('• T&C apply'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Redirecting to application...'),
                    ),
                  );
                },
                child: Text(offer.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
