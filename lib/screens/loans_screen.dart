// Loans screen displaying all user loans
import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../widgets/loan_card.dart';
import '../models/loan.dart';

class LoansScreen extends StatefulWidget {
  const LoansScreen({Key? key}) : super(key: key);

  @override
  State<LoansScreen> createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  String _selectedFilter = 'All'; // Filter: All, Active, Closed

  @override
  Widget build(BuildContext context) {
    final allLoans = MockDataService.getLoans();
    
    // Filter loans based on selected filter
    List<Loan> filteredLoans = allLoans.where((loan) {
      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Active') return loan.status == 'active';
      if (_selectedFilter == 'Closed') return loan.status == 'closed';
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        title: Text(
          'My Loans',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          // Filter icon
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary card
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade800],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Active Loans',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${allLoans.where((l) => l.status == 'active').length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹${_calculateTotalAmount(allLoans)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly EMI',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '₹${_calculateTotalEmi(allLoans)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Filter chips
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip('All'),
                SizedBox(width: 8),
                _buildFilterChip('Active'),
                SizedBox(width: 8),
                _buildFilterChip('Closed'),
              ],
            ),
          ),
          SizedBox(height: 16),
          
          // Loans list
          Expanded(
            child: filteredLoans.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No ${_selectedFilter.toLowerCase()} loans found',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredLoans.length,
                    itemBuilder: (context, index) {
                      return LoanCard(
                        loan: filteredLoans[index],
                        onTap: () {
                          _showLoanDetails(filteredLoans[index]);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      
      // Apply for new loan button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Apply for new loan feature coming soon!')),
          );
        },
        backgroundColor: Colors.blue.shade700,
        icon: Icon(Icons.add),
        label: Text('Apply for Loan'),
      ),
    );
  }

  // Build filter chip widget
  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: Colors.blue.shade700,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  // Show filter dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Filter Loans'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('All Loans'),
              leading: Radio(
                value: 'All',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value as String;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Active Loans'),
              leading: Radio(
                value: 'Active',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value as String;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Closed Loans'),
              leading: Radio(
                value: 'Closed',
                groupValue: _selectedFilter,
                onChanged: (value) {
                  setState(() {
                    _selectedFilter = value as String;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show loan details dialog
  void _showLoanDetails(Loan loan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loan.type),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan ID: ${loan.id}'),
            SizedBox(height: 8),
            Text('Amount: ₹${loan.amount.toStringAsFixed(0)}'),
            SizedBox(height: 8),
            Text('Interest Rate: ${loan.interestRate}%'),
            SizedBox(height: 8),
            Text('Tenure: ${loan.tenure} months'),
            SizedBox(height: 8),
            Text('EMI: ₹${loan.emiAmount.toStringAsFixed(0)}'),
            SizedBox(height: 8),
            Text('Status: ${loan.status}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  // Calculate total active loan amount
  String _calculateTotalAmount(List<Loan> loans) {
    double total = loans
        .where((l) => l.status == 'active')
        .fold(0, (sum, loan) => sum + loan.amount);
    return total.toStringAsFixed(0);
  }

  // Calculate total monthly EMI
  String _calculateTotalEmi(List<Loan> loans) {
    double total = loans
        .where((l) => l.status == 'active')
        .fold(0, (sum, loan) => sum + loan.emiAmount);
    return total.toStringAsFixed(0);
  }
}
