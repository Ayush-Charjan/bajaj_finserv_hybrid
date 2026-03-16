// Mock data service to provide sample data for the app
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/loan.dart';
import '../models/emi.dart';
import '../models/feature_item.dart';
import '../models/emi_type.dart';
import '../models/offer_card.dart';
import '../utils/app_colors.dart';

class MockDataService {
  // Mock user data
  static User getCurrentUser() {
    return User(
      id: '1',
      name: 'Rajesh Kumar',
      email: 'rajesh.kumar@example.com',
      phone: '+91 98765 43210',
      profileImage: 'assets/images/avatar_male.png',
    );
  }

  // Mock loan data
  static List<Loan> getLoans() {
    return [
      Loan(
        id: 'L001',
        type: 'Personal Loan',
        amount: 500000,
        interestRate: 10.5,
        tenure: 36,
        emiAmount: 16134,
        status: 'active',
        startDate: DateTime(2024, 1, 15),
      ),
      Loan(
        id: 'L002',
        type: 'Home Loan',
        amount: 3500000,
        interestRate: 8.5,
        tenure: 240,
        emiAmount: 27689,
        status: 'active',
        startDate: DateTime(2023, 6, 1),
      ),
      Loan(
        id: 'L003',
        type: 'Car Loan',
        amount: 800000,
        interestRate: 9.0,
        tenure: 60,
        emiAmount: 16597,
        status: 'closed',
        startDate: DateTime(2022, 3, 10),
      ),
    ];
  }

  // Mock EMI data
  static List<EMI> getUpcomingEmis() {
    return [
      EMI(
        id: 'E001',
        loanType: 'Personal Loan',
        emiAmount: 16134,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        isPaid: false,
        remainingEmis: 22,
      ),
      EMI(
        id: 'E002',
        loanType: 'Home Loan',
        emiAmount: 27689,
        dueDate: DateTime.now().add(const Duration(days: 12)),
        isPaid: false,
        remainingEmis: 178,
      ),
    ];
  }

  // Mock feature items for home screen
  static List<FeatureItem> getFeatures() {
    return [
      FeatureItem(
        title: 'Loans',
        icon: Icons.account_balance,
        color: AppColors.primary,
        route: '/loans',
      ),
      FeatureItem(
        title: 'Insurance',
        icon: Icons.shield,
        color: Colors.green.shade700,
        route: '/insurance',
      ),
      FeatureItem(
        title: 'Investments',
        icon: Icons.trending_up,
        color: Colors.orange.shade700,
        route: '/investments',
      ),
      FeatureItem(
        title: 'Pay Bills',
        icon: Icons.payment,
        color: Colors.purple.shade700,
        route: '/paybills',
      ),
    ];
  }

  // Get total credit limit
  static double getCreditLimit() {
    return 200000;
  }

  // Get available credit
  static double getAvailableCredit() {
    return 150000;
  }

  // Get EMI types
  static List<EmiType> getEmiTypes() {
    return [
      EmiType(
        id: '1',
        name: 'Gold Loan',
        icon: Icons.inventory_2,
        color: Colors.amber.shade700,
        description: 'Loans against gold at low interest',
        interestRate: 7.5,
        imagePath: 'assets/images/gold_emi.jpg',
      ),
      EmiType(
        id: '2',
        name: 'AC EMI',
        icon: Icons.ac_unit,
        color: Colors.blue.shade400,
        description: 'Easy EMI on Air Conditioners',
        interestRate: 0,
        imagePath: 'assets/images/ac_emi.jpg',
      ),
      EmiType(
        id: '3',
        name: 'Personal Loan',
        icon: Icons.person,
        color: Colors.purple.shade600,
        description: 'Quick personal loans',
        interestRate: 10.5,
        imagePath: 'assets/images/personal_loan.jpg',
      ),
      EmiType(
        id: '4',
        name: 'Two Wheeler',
        icon: Icons.two_wheeler,
        color: Colors.green.shade600,
        description: 'Bike loans at best rates',
        interestRate: 9.0,
        imagePath: 'assets/images/two_wheeler.jpg',
      ),
      EmiType(
        id: '5',
        name: 'Mobile EMI',
        icon: Icons.phone_android,
        color: Colors.orange.shade600,
        description: 'EMI on smartphones',
        interestRate: 0,
        imagePath: 'assets/images/mobile.jpg',
      ),
      EmiType(
        id: '6',
        name: 'Home Loan',
        icon: Icons.home,
        color: Colors.red.shade600,
        description: 'Home loans up to ₹15 Cr',
        interestRate: 8.5,
        imagePath: 'assets/images/home_loan.jpg',
      ),
    ];
  }

  // Get promotional offers
  static List<OfferCard> getOffers() {
    return [
      OfferCard(
        id: '1',
        title: 'Personal Loan',
        subtitle: 'Get up to ₹55 Lakh at low interest rates',
        buttonText: 'Apply Now',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFD4B2),
            Color(0xFFFFB28E),
          ],
        ),
        imageUrl: 'assets/images/instant_loan.jpg',
      ),
      OfferCard(
        id: '2',
        title: 'Home Loan',
        subtitle: 'Make your dream home a reality. Up to ₹15 Crores',
        buttonText: 'Check Offer',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 221, 197, 89),
            Color.fromARGB(255, 221, 137, 10),
          ],
        ),
        imageUrl: 'assets/images/home_loan.jpg',
      ),
      OfferCard(
        id: '3',
        title: 'Gold Loan',
        subtitle: 'Get instant money against your gold',
        buttonText: 'Know More',
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 236, 216, 99),
            Color.fromARGB(255, 236, 187, 23),
          ],
        ),
        imageUrl: 'assets/images/gold_emi.jpg',
      ),
    ];
  }

  // Get quick action items
  static List<Map<String, dynamic>> getQuickActions() {
    return [
      {
        'title': 'Offer',
        'icon': Icons.local_offer,
        'color': Colors.yellow.shade700,
        'image': 'assets/icons/rewards.png',
      },
      {
        'title': 'Loans',
        'icon': Icons.account_balance,
        'color': Colors.green.shade600,
        'image': 'assets/images/instant_loan.jpg',
      },
      {
        'title': 'Credit Card',
        'icon': Icons.credit_card,
        'color': Colors.blue.shade600,
        'image': 'assets/icons/wallet.png',
      },
      {
        'title': 'Grocery',
        'icon': Icons.shopping_bag,
        'color': Colors.orange.shade600,
        'image': 'assets/icons/shopping.png',
      },
      {
        'title': 'Finance Manager',
        'icon': Icons.assignment,
        'color': Colors.purple.shade600,
        'image': 'assets/icons/investment.png',
      },
      {
        'title': 'Stock Market',
        'icon': Icons.trending_up,
        'color': Colors.red.shade600,
        'image': 'assets/images/stock_market.png',
      },
    ];
  }

  // Get electronic products for EMI
  static List<Map<String, dynamic>> getElectronics() {
    return [
      {
        'name': 'Smartphones',
        'icon': Icons.phone_android,
        'discount': '10% off',
        'image': 'assets/images/mobile.jpg',
      },
      {
        'name': 'Laptops',
        'icon': Icons.laptop,
        'discount': '15% off',
        'image': 'assets/images/laptop.jpg',
      },
      {
        'name': 'TVs',
        'icon': Icons.tv,
        'discount': '20% off',
        'image': 'assets/images/tv.jpg',
      },
      {
        'name': 'AC',
        'icon': Icons.ac_unit,
        'discount': '12% off',
        'image': 'assets/images/ac_emi.jpg',
      },
      {
        'name': 'Refrigerator',
        'icon': Icons.kitchen,
        'discount': '8% off',
        'image': 'assets/images/refrigerator.jpg',
      },
    ];
  }

  // Get recharge services
  static List<Map<String, dynamic>> getRechargeServices() {
    return [
      {
        'name': 'Mobile Recharge',
        'icon': Icons.phone_android,
        'image': 'images/mobile.jpg',
      },
      {
        'name': 'DTH Recharge',
        'icon': Icons.tv,
        'image': 'assets/icons/dth.png',
      },
      {
        'name': 'Electricity Bill',
        'icon': Icons.flash_on,
        'image': 'assets/icons/electricity.png',
      },
      {
        'name': 'Water Bill',
        'icon': Icons.water_drop,
        'image': 'assets/icons/water.png',
      },
      {
        'name': 'Gas Bill',
        'icon': Icons.local_fire_department,
        'image': 'assets/icons/gas.png',
      },
    ];
  }
}
