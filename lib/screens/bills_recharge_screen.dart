import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BillsRechargeScreen extends StatefulWidget {
  final String? serviceType; // 'mobile', 'dth', 'electricity', 'water', 'gas'

  const BillsRechargeScreen({Key? key, this.serviceType}) : super(key: key);

  @override
  State<BillsRechargeScreen> createState() => _BillsRechargeScreenState();
}

class _BillsRechargeScreenState extends State<BillsRechargeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedService = 'mobile';
  final _numberController = TextEditingController();
  final _amountController = TextEditingController();

  final Map<String, Map<String, dynamic>> _services = {
    'mobile': {
      'title': 'Mobile Recharge',
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'hint': 'Enter mobile number',
    },
    'dth': {
      'title': 'DTH Recharge',
      'icon': Icons.tv,
      'color': Colors.purple,
      'hint': 'Enter subscriber ID',
    },
    'electricity': {
      'title': 'Electricity Bill',
      'icon': Icons.flash_on,
      'color': Colors.orange,
      'hint': 'Enter consumer number',
    },
    'water': {
      'title': 'Water Bill',
      'icon': Icons.water_drop,
      'color': Colors.cyan,
      'hint': 'Enter consumer number',
    },
    'gas': {
      'title': 'Gas Bill',
      'icon': Icons.local_fire_department,
      'color': Colors.red,
      'hint': 'Enter consumer number',
    },
  };

  @override
  void initState() {
    super.initState();
    if (widget.serviceType != null) {
      _selectedService = widget.serviceType!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = _services[_selectedService]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills & Recharge'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Type Selector
              const Text(
                'Select Service',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _services.length,
                  itemBuilder: (context, index) {
                    final key = _services.keys.elementAt(index);
                    final svc = _services[key]!;
                    final isSelected = key == _selectedService;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedService = key;
                          _numberController.clear();
                          _amountController.clear();
                        });
                      },
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              svc['icon'],
                              color: isSelected ? Colors.white : svc['color'],
                              size: 32,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              key.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Payment Form
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(service['icon'],
                                color: service['color'], size: 32),
                            const SizedBox(width: 12),
                            Text(
                              service['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Number/Consumer ID Field
                        TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: service['hint'],
                            border: const OutlineInputBorder(),
                            prefixIcon: Icon(service['icon']),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter details';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Amount Field
                        TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Enter amount',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.currency_rupee),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Quick Amount Buttons
                        const Text(
                          'Quick Amount',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [100, 200, 500, 1000, 2000]
                              .map((amount) => OutlinedButton(
                                    onPressed: () {
                                      _amountController.text =
                                          amount.toString();
                                    },
                                    child: Text('₹$amount'),
                                  ))
                              .toList(),
                        ),

                        const SizedBox(height: 24),

                        // Pay Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showPaymentDialog();
                              }
                            },
                            child: const Text(
                              'Proceed to Pay',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Recent Transactions
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildRecentTransaction(
                  'Mobile Recharge', '9876543210', 299, Icons.phone_android),
              _buildRecentTransaction(
                  'Electricity Bill', 'CON123456', 1500, Icons.flash_on),
              _buildRecentTransaction(
                  'DTH Recharge', 'DTH987654', 450, Icons.tv),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentTransaction(
      String title, String id, int amount, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title),
        subtitle: Text(id),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '₹$amount',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              'Paid',
              style: TextStyle(color: Colors.green, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 12),
            Text('Payment Initiated'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Service: ${_services[_selectedService]!['title']}'),
            Text('Number: ${_numberController.text}'),
            Text('Amount: ₹${_amountController.text}'),
            const SizedBox(height: 12),
            const Text(
              'Your payment is being processed. You will receive a confirmation shortly.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
