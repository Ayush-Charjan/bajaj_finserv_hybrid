import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../utils/app_colors.dart';
import 'offers_screen.dart';
import 'loans_screen.dart';
import 'credit_card_screen.dart';
import 'product_emi_screen.dart';
import 'finance_manager_screen.dart';
import 'investment_screen.dart';
import 'bills_recharge_screen.dart';
import 'notifications_screen.dart';
import 'cart_screen.dart';
import 'emi_screen.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  // Navy Blue Theme Colors
  final Color darkNavy = const Color.fromARGB(255, 14, 50, 105);

  Widget _assetImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget? fallback,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) =>
          fallback ?? const Icon(Icons.image_not_supported),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emiTypes = MockDataService.getEmiTypes();
    final offers = MockDataService.getOffers();
    final quickActions = MockDataService.getQuickActions();
    final electronics = MockDataService.getElectronics();
    final rechargeServices = MockDataService.getRechargeServices();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            /// TOP BAR
            _buildTopBar(context),

            /// MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildPromoBanner(context, offers.first),
                    const SizedBox(height: 16),
                    _buildQuickActionsGrid(quickActions),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Select EMI Type'),
                    _buildEmiTypesRow(emiTypes),
                    const SizedBox(height: 20),
                    _buildBigEmiCard(context, emiTypes),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Bills & Recharge'),
                    _buildRechargeRow(rechargeServices),
                    const SizedBox(height: 20),
                    _buildSectionTitle('EMIs on Electronics'),
                    _buildElectronicsRow(electronics),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Exclusive Loan Offers'),
                    _buildLoanOffers(offers),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// NAVY BLUE HEADER
  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: darkNavy,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36, // Slightly increased for better scale
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                // ClipRRect ensures the image stays inside the rounded corners
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: _assetImage(
                      'assets/logos/app_icon.png',
                      fit: BoxFit.contain,
                      fallback: const Icon(
                        Icons.account_balance,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              /// TITLE (Wrapped in Expanded to fix horizontal overflow)
              const Expanded(
                child: Text(
                  "FINANCE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// CART
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                constraints: const BoxConstraints(), // Reduces default padding
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),

              /// EMI CARD
              IconButton(
                icon: const Icon(Icons.credit_card, color: Colors.cyanAccent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmiScreen()),
                  );
                },
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),

              /// PRIME
              const Text(
                "prime",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(width: 4),

              const CircleAvatar(
                radius: 4,
                backgroundColor: Colors.cyanAccent,
              ),

              const SizedBox(width: 8),

              /// NOTIFICATION
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsScreen()),
                  );
                },
                child: Stack(
                  children: [
                    const Icon(Icons.notifications_none, color: Colors.white),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// SEARCH BAR
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.15), // Subtle drop shadow for depth
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              cursorColor: darkNavy, // Cursor matches your theme
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: "Search here...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,

                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

                /// SEARCH ICON
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 4.0),
                  child: Icon(Icons.search, color: darkNavy, size: 24),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),

                /// MIC ICON
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 207, 201, 201),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.mic,
                        color: darkNavy.withOpacity(0.7), size: 20),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 45,
                  minHeight: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context, dynamic offer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      decoration: BoxDecoration(
        color: offer.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _assetImage(
                'assets/images/personal_loan.jpg',
                width: 64,
                height: 64,
                fallback: const Icon(Icons.account_balance_wallet, size: 40),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    offer.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offer.subtitle,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkNavy,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoansScreen()),
                );
              },
              child: const Text("Apply"),
            )
          ],
        ),
      ),
    );
  }

  /// QUICK ACTION GRID (Fixed childAspectRatio)
  Widget _buildQuickActionsGrid(List<Map<String, dynamic>> actions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio:
              0.85, // Adjust this if you still get vertical clipping
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return GestureDetector(
            onTap: () {
              _navigateToQuickAction(context, action['title']);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _assetImage(
                    action['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    fallback:
                        Icon(action['icon'], color: action['color'], size: 40),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  action['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToQuickAction(BuildContext context, String title) {
    Widget? screen;
    switch (title) {
      case 'Offer':
        screen = const OffersScreen();
        break;
      case 'Loans':
        screen = const LoansScreen();
        break;
      case 'Credit Card':
        screen = const CreditCardScreen();
        break;
      case 'Grocery':
        screen = const ProductEmiScreen();
        break;
      case 'Finance Manager':
        screen = const FinanceManagerScreen();
        break;
      case 'Stock Market':
        screen = const InvestmentScreen();
        break;
    }
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen!));
    }
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: darkNavy,
        ),
      ),
    );
  }

  /// EMI TYPES (Increased height to 130)
  Widget _buildEmiTypesRow(List emiTypes) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: emiTypes.length,
        itemBuilder: (context, index) {
          final type = emiTypes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => type.name.contains('Loan')
                      ? const LoansScreen()
                      : const ProductEmiScreen(),
                ),
              );
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: _assetImage(
                      type.imagePath,
                      fit: BoxFit.cover,
                      fallback: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: Icon(type.icon, color: type.color),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    type.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// BIG EMI CARD
  Widget _buildBigEmiCard(BuildContext context, List emiTypes) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: darkNavy,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Choose Your EMI Plan",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: darkNavy,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmiScreen()),
              );
            },
            child: const Text("Explore EMI Options"),
          )
        ],
      ),
    );
  }

  /// RECHARGE SERVICES (Increased height to 130)
  Widget _buildRechargeRow(List<Map<String, dynamic>> services) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BillsRechargeScreen(
                    serviceType: _getServiceType(service['name']),
                  ),
                ),
              );
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _assetImage(
                      service['image'],
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,
                      fallback: Icon(
                        service['icon'],
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    service['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getServiceType(String name) {
    if (name.contains('Mobile')) return 'mobile';
    if (name.contains('DTH')) return 'dth';
    if (name.contains('Electricity')) return 'electricity';
    if (name.contains('Water')) return 'water';
    if (name.contains('Gas')) return 'gas';
    return 'mobile';
  }

  /// ELECTRONICS (Increased height to 180)
  Widget _buildElectronicsRow(List<Map<String, dynamic>> items) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductEmiScreen(
                    productType: item['name'].toString().toLowerCase(),
                  ),
                ),
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12, bottom: 8, top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _assetImage(
                      item['image'],
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      fallback: Icon(item['icon'], size: 40, color: darkNavy),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['name'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['discount'],
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// LOAN OFFERS (Increased height to 200)
  Widget _buildLoanOffers(List offers) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Container(
            width: 260,
            margin: const EdgeInsets.only(
                right: 16, bottom: 8), // Bottom margin for breathing room
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: offer.backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: _assetImage(
                    offer.imageUrl,
                    width: double.infinity,
                    height: 72,
                    fallback: const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  offer.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    offer.subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkNavy,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => offer.title.contains('Loan')
                            ? const LoansScreen()
                            : const OffersScreen(),
                      ),
                    );
                  },
                  child: Text(offer.buttonText),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
