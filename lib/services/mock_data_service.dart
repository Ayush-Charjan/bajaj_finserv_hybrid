// Mock data service to provide sample data for the app
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/loan.dart';
import '../models/emi.dart';
import '../models/feature_item.dart';

class MockDataService {
  // Mock user data
  static User getCurrentUser() {
    return User(
      id: '1',
      name: 'Rajesh Kumar',
      email: 'rajesh.kumar@example.com',
      phone: '+91 98765 43210',
      profileImage: 'assets/profile.png',
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
        dueDate: DateTime.now().add(Duration(days: 5)),
        isPaid: false,
        remainingEmis: 22,
      ),
      EMI(
        id: 'E002',
        loanType: 'Home Loan',
        emiAmount: 27689,
        dueDate: DateTime.now().add(Duration(days: 12)),
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
        color: Colors.blue.shade700,
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
}
