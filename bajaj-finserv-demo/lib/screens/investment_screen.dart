import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Market & Investments'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Portfolio Summary
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade900],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Portfolio Value',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₹4,20,350',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.trending_up,
                            color: Colors.greenAccent, size: 20),
                        const SizedBox(width: 4),
                        const Text(
                          '+₹12,450',
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '+3.05%',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                        'Buy', Icons.add_circle, Colors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                        'Sell', Icons.remove_circle, Colors.red),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction('SIP', Icons.repeat, Colors.blue),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Market Indices
              const Text(
                'Market Indices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildIndexItem('NIFTY 50', 22145.65, 245.30, 1.12, true),
                      const Divider(),
                      _buildIndexItem(
                          'SENSEX', 72950.45, -150.20, -0.21, false),
                      const Divider(),
                      _buildIndexItem(
                          'NIFTY BANK', 47890.30, 380.50, 0.80, true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // My Holdings
              const Text(
                'My Holdings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildStockCard('Reliance Industries', 'RELIANCE', 2550.50, 45.20,
                  1.80, true, 10),
              _buildStockCard('Tata Consultancy Services', 'TCS', 3680.75,
                  -22.30, -0.60, false, 5),
              _buildStockCard(
                  'Infosys', 'INFY', 1450.20, 18.50, 1.29, true, 15),
              _buildStockCard(
                  'HDFC Bank', 'HDFCBANK', 1620.40, 35.80, 2.26, true, 8),
              _buildStockCard(
                  'ICICI Bank', 'ICICIBANK', 980.65, -5.40, -0.55, false, 20),

              const SizedBox(height: 24),

              // Investment Options
              const Text(
                'Investment Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildInvestmentOption(
                'Mutual Funds',
                'SIP starting from ₹500/month',
                Icons.pie_chart,
                Colors.blue,
              ),
              _buildInvestmentOption(
                'Fixed Deposits',
                'Guaranteed returns up to 7.5%',
                Icons.account_balance,
                Colors.green,
              ),
              _buildInvestmentOption(
                'Gold Investment',
                'Digital gold starting at ₹100',
                Icons.currency_rupee,
                Colors.orange,
              ),
              _buildInvestmentOption(
                'Insurance',
                'ULIP & Term plans available',
                Icons.shield,
                Colors.purple,
              ),

              const SizedBox(height: 24),

              // Market News
              const Text(
                'Market News & Updates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildNewsCard(
                'Markets end higher on IT sector gains',
                'The Sensex and Nifty closed higher today driven by IT stocks...',
                '2 hours ago',
              ),
              _buildNewsCard(
                'RBI keeps repo rate unchanged at 6.5%',
                'Reserve Bank of India maintains status quo on key interest rates...',
                '5 hours ago',
              ),
              _buildNewsCard(
                'Fresh FII inflows boost market sentiment',
                'Foreign institutional investors pumped in ₹5,000 crores...',
                '1 day ago',
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(String label, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndexItem(String name, double value, double change,
      double changePercent, bool isPositive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16,
                ),
                Text(
                  '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
              style: TextStyle(
                color: isPositive ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStockCard(
    String name,
    String symbol,
    double price,
    double change,
    double changePercent,
    bool isPositive,
    int quantity,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              isPositive ? Colors.green.shade100 : Colors.red.shade100,
          child: Text(
            symbol.substring(0, 2),
            style: TextStyle(
              color: isPositive ? Colors.green.shade800 : Colors.red.shade800,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '$quantity shares • ₹${(price * quantity).toStringAsFixed(2)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 12,
                ),
                Text(
                  '${changePercent.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositive ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentOption(
      String title, String subtitle, IconData icon, Color color) {
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
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  Widget _buildNewsCard(String title, String description, String time) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
