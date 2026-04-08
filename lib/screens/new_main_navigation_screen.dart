// New Main Navigation with 6 bottom tabs
import 'package:flutter/material.dart';
import 'new_home_screen.dart';
import 'profile_screen.dart';
import 'scan_qr_screen.dart';
import 'pay_emi_screen.dart';
import 'menu_screen.dart';
import 'chat_screen.dart';
import '../utils/app_colors.dart';
import '../services/native_footer_bridge.dart';

class NewMainNavigationScreen extends StatefulWidget {
  final bool isEmbedded;

  const NewMainNavigationScreen({Key? key, this.isEmbedded = false})
      : super(key: key);

  @override
  State<NewMainNavigationScreen> createState() =>
      _NewMainNavigationScreenState();
}

class _NewMainNavigationScreenState extends State<NewMainNavigationScreen> {
  int _currentIndex = 0;
  final NativeFooterBridge _nativeFooterBridge = NativeFooterBridge();

  List<Widget> get _screens => [
        NewHomeScreen(isEmbedded: widget.isEmbedded),
        const ProfileScreen(),
        Container(), // Placeholder for Scan QR (opens as modal)
        const PayEmiScreen(),
        const MenuScreen(),
        const ChatScreen(),
      ];

  @override
  void initState() {
    super.initState();
    if (widget.isEmbedded) {
      _nativeFooterBridge.register(_onNativeFooterTap);
    }
  }

  void _onNativeFooterTap(int nativeIndex) {
    final int? mapped = _mapNativeFooterIndexToWebTab(nativeIndex);
    if (mapped == null || !mounted) {
      return;
    }
    setState(() {
      _currentIndex = mapped;
    });
  }

  int? _mapNativeFooterIndexToWebTab(int nativeIndex) {
    switch (nativeIndex) {
      case 0:
        return 0; // Home
      case 1:
        return 3; // Pay EMI
      case 3:
        return 4; // Menu
      case 4:
        return 5; // Chat
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _nativeFooterBridge.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 2
          ? NewHomeScreen(
              isEmbedded: widget.isEmbedded) // Show home if scan QR is selected
          : _screens[_currentIndex],
      bottomNavigationBar: widget.isEmbedded
          ? null
          : Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  if (index == 2) {
                    // Open Scan QR as a full screen modal
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanQRScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  } else {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: Colors.grey.shade600,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.qr_code_scanner,
                          color: Colors.white, size: 24),
                    ),
                    label: 'Scan QR',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.payment_outlined),
                    activeIcon: Icon(Icons.payment),
                    label: 'Pay EMI',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    activeIcon: Icon(Icons.menu_open),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      children: [
                        const Icon(Icons.chat_bubble_outline),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    activeIcon: const Icon(Icons.chat_bubble),
                    label: 'Chat',
                  ),
                ],
              ),
            ),
    );
  }
}
