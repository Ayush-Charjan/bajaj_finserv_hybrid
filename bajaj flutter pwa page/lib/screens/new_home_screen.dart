import 'package:flutter/material.dart';
import 'dart:async';
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
import 'scan_qr_screen.dart';
import 'service_mock_screen.dart';
import 'quick_service_form_screen.dart';
import '../services/native_shell_bridge.dart';

// Main content area between top bar and bottom navigation bar
class NewHomeMainContent extends StatefulWidget {
  const NewHomeMainContent({Key? key}) : super(key: key);

  @override
  State<NewHomeMainContent> createState() => _NewHomeMainContentState();
}

class _NewHomeMainContentState extends State<NewHomeMainContent> {
  final PageController _bannerController =
      PageController(viewportFraction: 0.9);
  Timer? _bannerTimer;
  int _bannerIndex = 0;

  final List<Map<String, dynamic>> _offers = const [
    {
      'label': 'Festive Offer',
      'image': 'assets/images/instant_loan.jpg',
      'color': Color(0xFFFF9800),
    },
    {
      'label': 'AC EMI',
      'image': 'assets/images/refrigerator.jpg',
      'color': Color(0xFF1E88E5),
    },
    {
      'label': 'Home Loan',
      'image': 'assets/images/home_loan.jpg',
      'color': Color(0xFF6A1B9A),
    },
    {
      'label': 'Personal Loan',
      'image': 'assets/images/personal_loan.jpg',
      'color': Color(0xFF43A047),
    },
    {
      'label': 'Car Loan',
      'image': 'assets/images/car_loan.jpg',
      'color': Color(0xFF00897B),
    },
    {
      'label': '2 Wheeler',
      'image': 'assets/images/two_wheeler.jpg',
      'color': Color(0xFFEF6C00),
    },
  ];

  final List<Map<String, dynamic>> _banners = const [
    {
      'title': 'Home Loan',
      'subtitle': 'Starts at 7.15% p.a.',
      'image': 'assets/images/banner1.jpg',
      'color': Color(0xFF5A2D82),
    },
    {
      'title': 'EMI on Electronics',
      'subtitle': 'No-cost EMI available',
      'image': 'assets/images/banner2.jpg',
      'color': Color(0xFF1565C0),
    },
    {
      'title': 'Personal Loan',
      'subtitle': 'Quick approval in minutes',
      'image': 'assets/images/banner3.jpg',
      'color': Color(0xFF2E7D32),
    },
    {
      'title': 'Festive Cashback',
      'subtitle': 'Extra savings on every purchase',
      'image': 'assets/images/banner4.jpg',
      'color': Color(0xFFEF6C00),
    },
    {
      'title': 'Premium Benefits',
      'subtitle': 'Unlock offers with Prime plans',
      'image': 'assets/images/banner5.jpg',
      'color': Color(0xFF3949AB),
    },
    {
      'title': 'Smart EMI Plans',
      'subtitle': 'Flexible tenure, lower monthly payout',
      'image': 'assets/images/banner6.jpg',
      'color': Color(0xFF00897B),
    },
    {
      'title': 'Loan Top Deals',
      'subtitle': 'Get instant eligibility checks',
      'image': 'assets/images/banner7.jpg',
      'color': Color(0xFFD81B60),
    },
  ];

  final List<Map<String, dynamic>> _featureGroups = const [
    {
      'title': 'Popular Services',
      'items': [
        {
          'label': 'Shopping',
          'icon': 'assets/icons/shopping.png',
          'color': Color(0xFFE53935),
        },
        {
          'label': 'Rewards',
          'icon': 'assets/icons/rewards.png',
          'color': Color(0xFFFFB300),
        },
        {
          'label': 'Wallet',
          'icon': 'assets/icons/wallet.png',
          'color': Color(0xFF1E88E5),
        },
        {
          'label': 'Invest',
          'icon': 'assets/icons/investment.png',
          'color': Color(0xFF43A047),
        },
      ],
    },
    {
      'title': 'Quick Access',
      'items': [
        {
          'label': 'Bills',
          'icon': 'assets/icons/bills.png',
          'color': Color(0xFF3949AB),
        },
        {
          'label': 'Recharge',
          'icon': 'assets/icons/recharge.png',
          'color': Color(0xFF8E24AA),
        },
        {
          'label': 'Insurance',
          'icon': 'assets/icons/insurance.png',
          'color': Color(0xFFD81B60),
        },
        {
          'label': 'Transfer',
          'icon': 'assets/icons/transfer.png',
          'color': Color(0xFF00897B),
        },
      ],
    },
    {
      'title': 'Loan Types',
      'items': [
        {
          'label': 'Gold',
          'icon': 'assets/images/gold_emi.jpg',
          'color': Color(0xFFF57C00),
        },
        {
          'label': 'Medical',
          'icon': 'assets/images/medical_loan.jpg',
          'color': Color(0xFF00838F),
        },
        {
          'label': 'Business',
          'icon': 'assets/images/business_loan.jpg',
          'color': Color(0xFF6D4C41),
        },
        {
          'label': 'Education',
          'icon': 'assets/images/education_loan.jpg',
          'color': Color(0xFF5E35B1),
        },
      ],
    },
  ];

  final List<Map<String, dynamic>> _billItems = const [
    {
      'label': 'Electricity',
      'icon': 'assets/icons/electricity.png',
      'color': Color(0xFFFF9800),
    },
    {
      'label': 'Mobile Recharge',
      'icon': 'assets/icons/recharge.png',
      'color': Color(0xFF43A047),
    },
    {
      'label': 'Water Bill',
      'icon': 'assets/icons/water.png',
      'color': Color(0xFF1E88E5),
    },
    {
      'label': 'DTH/Cable',
      'icon': 'assets/icons/dth.png',
      'color': Color(0xFF8E24AA),
    },
    {
      'label': 'Broadband',
      'icon': 'assets/icons/broadband.png',
      'color': Color(0xFF3949AB),
    },
    {
      'label': 'Gas Bill',
      'icon': 'assets/icons/gas.png',
      'color': Color(0xFF6D4C41),
    },
  ];

  @override
  void initState() {
    super.initState();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_bannerController.hasClients) {
        return;
      }
      final next = (_bannerIndex + 1) % _banners.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  Widget _assetImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => Icon(
        Icons.image_not_supported_outlined,
        size: (width ?? 24) * 0.65,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          _buildOfferRow(),
          const SizedBox(height: 10),
          _buildAutoBanners(),
          const SizedBox(height: 10),
          _buildFeatureGroupCards(),
          const SizedBox(height: 10),
          _buildBillsAndRecharge(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildOfferRow() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: _offers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final item = _offers[index];
          final color = item['color'] as Color;
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => _openOffer(context, item['label'] as String),
            child: SizedBox(
              width: 82,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.16),
                      shape: BoxShape.circle,
                      border: Border.all(color: color.withOpacity(0.35)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                        child: _assetImage(
                          item['image'] as String,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['label'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAutoBanners() {
    return Column(
      children: [
        SizedBox(
          height: 166,
          child: PageView.builder(
            controller: _bannerController,
            itemCount: _banners.length,
            onPageChanged: (index) {
              setState(() {
                _bannerIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: AssetImage(banner['image'] as String),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black.withOpacity(0.45),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                        onTap: () =>
                            _openBanner(context, banner['title'] as String),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Apply Now',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            final selected = _bannerIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: selected ? 14 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFeatureGroupCards() {
    return SizedBox(
      height: 194,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: _featureGroups.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final group = _featureGroups[index];
          final items = group['items'] as List<dynamic>;
          return Container(
            width: 188,
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['title'] as String,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, i) {
                      final item = items[i] as Map<String, dynamic>;
                      final color = item['color'] as Color;
                      return Container(
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () =>
                              _openFeature(context, item['label'] as String),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 2,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: _assetImage(
                                    item['icon'] as String,
                                    width: 38,
                                    height: 38,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['label'] as String,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBillsAndRecharge() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bills & Recharge',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 124,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _billItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final item = _billItems[index];
                final color = item['color'] as Color;
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _openBillItem(context, item['label'] as String),
                  child: Container(
                    width: 98,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.18),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: _assetImage(
                                item['icon'] as String,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            item['label'] as String,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void _openOffer(BuildContext context, String label) {
    switch (label) {
      case 'Festive Offer':
        _push(context, const OffersScreen());
        return;
      case 'Home Loan':
      case 'Personal Loan':
      case 'Car Loan':
      case '2 Wheeler':
        _push(context, const LoansScreen());
        return;
      case 'AC EMI':
        _push(context, const ProductEmiScreen(productType: 'ac'));
        return;
      default:
        _push(context, ServiceMockScreen(serviceName: label));
    }
  }

  void _openBanner(BuildContext context, String title) {
    if (title.contains('Loan')) {
      _push(context, const LoansScreen());
      return;
    }
    if (title.contains('EMI')) {
      _push(context, const EmiScreen());
      return;
    }
    _push(context, const OffersScreen());
  }

  void _openFeature(BuildContext context, String label) {
    switch (label) {
      case 'Shopping':
        _push(context, const CartScreen());
        return;
      case 'Rewards':
        _push(context, const OffersScreen());
        return;
      case 'Wallet':
        _push(context, const FinanceManagerScreen());
        return;
      case 'Invest':
        _push(context, const InvestmentScreen());
        return;
      case 'Bills':
      case 'Recharge':
        _push(context, const BillsRechargeScreen(serviceType: 'mobile'));
        return;
      case 'Insurance':
        _push(
          context,
          const QuickServiceFormScreen(
            title: 'Insurance Premium',
            icon: Icons.shield_outlined,
            color: Color(0xFFD81B60),
            primaryFieldLabel: 'Policy Number',
            primaryFieldHint: 'Enter policy number',
            ctaLabel: 'Pay Premium',
          ),
        );
        return;
      case 'Transfer':
        _push(
          context,
          const QuickServiceFormScreen(
            title: 'Money Transfer',
            icon: Icons.send_outlined,
            color: Color(0xFF00897B),
            primaryFieldLabel: 'Recipient UPI / Account',
            primaryFieldHint: 'Enter UPI ID or account number',
            ctaLabel: 'Send Money',
          ),
        );
        return;
      case 'Gold':
      case 'Medical':
      case 'Business':
      case 'Education':
        _push(context, const LoansScreen());
        return;
      default:
        _push(context, ServiceMockScreen(serviceName: label));
    }
  }

  void _openBillItem(BuildContext context, String label) {
    final key = label.toLowerCase();
    if (key.contains('broadband')) {
      _push(
        context,
        const QuickServiceFormScreen(
          title: 'Broadband Bill',
          icon: Icons.wifi,
          color: Color(0xFF3949AB),
          primaryFieldLabel: 'Customer ID',
          primaryFieldHint: 'Enter broadband customer ID',
          ctaLabel: 'Pay Bill',
        ),
      );
      return;
    }
    final serviceType = key.contains('electricity')
        ? 'electricity'
        : key.contains('water')
            ? 'water'
            : key.contains('gas')
                ? 'gas'
                : key.contains('dth')
                    ? 'dth'
                    : 'mobile';
    _push(context, BillsRechargeScreen(serviceType: serviceType));
  }
}

class NewHomeScreen extends StatefulWidget {
  final bool isEmbedded;
  final bool useNativeShell;

  const NewHomeScreen({
    Key? key,
    this.isEmbedded = false,
    this.useNativeShell = false,
  }) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  Timer? _backgroundTimer;
  int _backgroundIndex = 0;
  final NativeShellBridge _nativeShellBridge = NativeShellBridge();

  final List<String> _backgroundImages = const [
    'assets/images/glass background.jpg',
    'assets/images/glass background 2.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _backgroundTimer = Timer.periodic(const Duration(seconds: 9), (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _backgroundIndex = (_backgroundIndex + 1) % _backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _backgroundTimer?.cancel();
    super.dispose();
  }

  // Navy Blue Theme Colors
  // Primary Theme Color
  final Color darkNavy = AppColors.primary;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1400),
                child: SizedBox.expand(
                  key: ValueKey<int>(_backgroundIndex),
                  child: Opacity(
                    opacity: 0.16,
                    child: Image.asset(
                      _backgroundImages[_backgroundIndex],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox.expand(
                          child: ColoredBox(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.82),
              ),
            ),
            Column(
              children: [
                /// TOP BAR (hide when embedded or when native shell owns chrome) 
                if (!widget.isEmbedded && !widget.useNativeShell)
                  _buildTopBar(context),

                /// MAIN CONTENT (between top bar and bottom nav)
                const Expanded(
                  child: NewHomeMainContent(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// NAVY BLUE HEADER
  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 42, 84, 1),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
      child: Column(
        children: [
          /// TOP ROW (SMALL)
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Image.asset('assets/logos/app_icon.png',
                      fit: BoxFit.contain),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                "FINANCE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                child: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.white, size: 24),
              ),
              const SizedBox(width: 10),
              const SizedBox(width: 8),
              const SizedBox(width: 8),
              const SizedBox(width: 8),
              const SizedBox(height: 6),

              /// EMI
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EmiScreen()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "EMI",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// PRIME
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OffersScreen(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Text("prime",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    SizedBox(width: 3),
                    CircleAvatar(radius: 3, backgroundColor: Colors.orange),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
                child: const Stack(
                  children: [
                    Icon(Icons.notifications_none,
                        color: Colors.white, size: 24),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// SEARCH + QR (SMALL)
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F5),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Search Bajajfinserv.in",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            isDense: true,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ServiceMockScreen(
                                serviceName: 'Voice Search',
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.mic_none,
                            color: Colors.grey, size: 24),
                      ),
                      Container(
                        width: 48,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8E9DB),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(7),
                            bottomRight: Radius.circular(7),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ServiceMockScreen(
                                  serviceName: 'Search',
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.search,
                              color: Color(0xFFEF6C00), size: 26),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 6),

              /// QR
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScanQRScreen()),
                  );
                },
                child: Container(
                  width: 36,
                  height: 42,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Icon(Icons.qr_code_scanner,
                      color: Colors.white, size: 18),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          const Text(
            "BAJAJ FINANCE LIMITED",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
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
