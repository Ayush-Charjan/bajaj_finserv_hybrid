import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../utils/app_colors.dart';

class ProductEmiScreen extends StatelessWidget {
  final String? productType; // 'mobile', 'laptop', 'tv', 'ac', 'refrigerator'

  const ProductEmiScreen({Key? key, this.productType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final electronics = MockDataService.getElectronics();
    final selectedProduct = productType ?? 'mobile';

    return Scaffold(
      appBar: AppBar(
        title: const Text('EMI on Electronics'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Selector
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: electronics.length,
                  itemBuilder: (context, index) {
                    final item = electronics[index];
                    final isSelected = item['name']
                        .toString()
                        .toLowerCase()
                        .contains(selectedProduct);
                    return GestureDetector(
                      onTap: () {
                        // Navigate to specific product category
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
                              item['icon'],
                              color:
                                  isSelected ? Colors.white : AppColors.primary,
                              size: 32,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // EMI Benefits Banner
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0% Interest EMI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Zero down payment\n• Instant approval\n• Flexible tenure up to 24 months',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Featured Products
              const Text(
                'Featured Products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Product Cards
              _buildProductCard(
                'iPhone 15 Pro',
                'Apple',
                134900,
                'assets/images/mobile.jpg',
                '5623 EMI starts at',
                Icons.phone_iphone,
              ),
              _buildProductCard(
                'MacBook Air M2',
                'Apple',
                114900,
                'assets/images/laptop.jpg',
                '4787 EMI starts at',
                Icons.laptop_mac,
              ),
              _buildProductCard(
                'Samsung 55" 4K Smart TV',
                'Samsung',
                54900,
                'assets/images/tv.jpg',
                '2287 EMI starts at',
                Icons.tv,
              ),
              _buildProductCard(
                'LG 1.5 Ton Inverter AC',
                'LG',
                42900,
                'assets/images/ac_emi.jpg',
                '1787 EMI starts at',
                Icons.ac_unit,
              ),
              _buildProductCard(
                'Samsung 350L Refrigerator',
                'Samsung',
                38900,
                'assets/images/refrigerator.jpg',
                '1620 EMI starts at',
                Icons.kitchen,
              ),

              const SizedBox(height: 24),

              // EMI Calculator
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'EMI Calculator',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Product Price',
                          prefixIcon: Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      const Text('Select Tenure:'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [3, 6, 9, 12, 18, 24]
                            .map((months) => ChoiceChip(
                                  label: Text('$months months'),
                                  selected: months == 12,
                                  selectedColor: AppColors.primary,
                                  labelStyle: TextStyle(
                                    color: months == 12
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  onSelected: (selected) {},
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Monthly EMI:',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '₹ __.__',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    String name,
    String brand,
    int price,
    String imagePath,
    String emiText,
    IconData fallbackIcon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                fallbackIcon,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    brand,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '₹${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.credit_card,
                          size: 14, color: Colors.green.shade700),
                      const SizedBox(width: 4),
                      Text(
                        '₹$emiText',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Buy Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () {},
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
