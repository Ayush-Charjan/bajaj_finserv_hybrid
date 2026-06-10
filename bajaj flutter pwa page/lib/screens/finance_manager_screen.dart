import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class FinanceManagerScreen extends StatelessWidget {
  const FinanceManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Manager'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Financial Summary Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₹8,45,230',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBalanceItem('Income', '₹1,50,000',
                              Icons.arrow_downward, Colors.green),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white30,
                        ),
                        Expanded(
                          child: _buildBalanceItem('Expenses', '₹65,500',
                              Icons.arrow_upward, Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Investments', '₹4,20,000',
                        Icons.trending_up, Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                        'Savings', '₹2,15,000', Icons.savings, Colors.blue),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Monthly Budget
              const Text(
                'Monthly Budget',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildBudgetItem(
                          'Food & Dining', 12000, 15000, Colors.orange),
                      const SizedBox(height: 12),
                      _buildBudgetItem('Shopping', 8000, 10000, Colors.purple),
                      const SizedBox(height: 12),
                      _buildBudgetItem('Transport', 5000, 8000, Colors.blue),
                      const SizedBox(height: 12),
                      _buildBudgetItem('Entertainment', 6500, 7000, Colors.red),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTransactionItem(
                'Grocery Shopping',
                'Reliance Fresh',
                DateTime.now().subtract(const Duration(hours: 2)),
                -2500,
                Icons.shopping_cart,
                Colors.orange,
              ),
              _buildTransactionItem(
                'Salary Credit',
                'Company ABC',
                DateTime.now().subtract(const Duration(days: 1)),
                150000,
                Icons.account_balance,
                Colors.green,
              ),
              _buildTransactionItem(
                'Electricity Bill',
                'MSEB',
                DateTime.now().subtract(const Duration(days: 2)),
                -1500,
                Icons.flash_on,
                Colors.blue,
              ),
              _buildTransactionItem(
                'Restaurant',
                'Barbeque Nation',
                DateTime.now().subtract(const Duration(days: 3)),
                -3200,
                Icons.restaurant,
                Colors.red,
              ),
              _buildTransactionItem(
                'Fuel',
                'HP Petrol Pump',
                DateTime.now().subtract(const Duration(days: 4)),
                -2000,
                Icons.local_gas_station,
                Colors.purple,
              ),

              const SizedBox(height: 24),

              // Financial Goals
              const Text(
                'Financial Goals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildGoalCard('Emergency Fund', 500000, 650000, '77%'),
              _buildGoalCard('Vacation Fund', 80000, 150000, '53%'),
              _buildGoalCard('New Car', 300000, 800000, '37%'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          _showAddTransactionDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBalanceItem(
      String label, String amount, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String label, String amount, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetItem(String category, int spent, int budget, Color color) {
    final percentage = (spent / budget * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '₹$spent / ₹$budget',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: spent / budget,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage% used',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String subtitle,
    DateTime date,
    int amount,
    IconData icon,
    Color color,
  ) {
    final isCredit = amount > 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text('$subtitle • ${_formatDate(date)}'),
        trailing: Text(
          '${isCredit ? '+' : ''} ₹${amount.abs()}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isCredit ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(
      String title, int saved, int target, String percentage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  percentage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: saved / target,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              '₹${_formatCurrency(saved)} / ₹${_formatCurrency(target)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    }
    return DateFormat('dd MMM').format(date);
  }

  String _formatCurrency(int amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)}L';
    }
    return amount.toString();
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Transaction'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixIcon: Icon(Icons.currency_rupee),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaction added')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
