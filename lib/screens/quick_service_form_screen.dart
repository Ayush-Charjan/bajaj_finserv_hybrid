import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuickServiceFormScreen extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String primaryFieldLabel;
  final String primaryFieldHint;
  final String amountLabel;
  final String ctaLabel;

  const QuickServiceFormScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.primaryFieldLabel,
    required this.primaryFieldHint,
    this.amountLabel = 'Amount',
    this.ctaLabel = 'Continue',
  }) : super(key: key);

  @override
  State<QuickServiceFormScreen> createState() => _QuickServiceFormScreenState();
}

class _QuickServiceFormScreenState extends State<QuickServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _primaryController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _primaryController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Submitted'),
        content: Text(
          '${widget.title} request created for ${_primaryController.text}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: widget.color.withOpacity(0.16),
                        child: Icon(widget.icon, color: widget.color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _primaryController,
                    decoration: InputDecoration(
                      labelText: widget.primaryFieldLabel,
                      hintText: widget.primaryFieldHint,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter ${widget.primaryFieldLabel.toLowerCase()}';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: widget.amountLabel,
                      hintText: 'Enter amount',
                      prefixIcon: const Icon(Icons.currency_rupee),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter amount';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [299, 499, 999, 1499]
                        .map(
                          (amount) => OutlinedButton(
                            onPressed: () {
                              _amountController.text = amount.toString();
                            },
                            child: Text('Rs $amount'),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(widget.ctaLabel),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
