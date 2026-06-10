// New Main Navigation with 6 bottom tabs
import 'package:flutter/material.dart';
import 'new_home_screen.dart';
import 'profile_screen.dart';
import 'scan_qr_screen.dart';
import 'pay_emi_screen.dart';
import 'menu_screen.dart';
import 'chat_screen.dart';
import '../utils/app_colors.dart';
import '../services/native_shell_bridge.dart';

class NewMainNavigationScreen extends StatefulWidget {
  final bool isEmbedded;
  final bool useNativeShell;
  final int initialIndex;

  const NewMainNavigationScreen({
    Key? key,
    this.isEmbedded = false,
    this.useNativeShell = false,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<NewMainNavigationScreen> createState() =>
      _NewMainNavigationScreenState();
}

class _NewMainNavigationScreenState extends State<NewMainNavigationScreen> {
  late int _currentIndex;
  final NativeShellBridge _nativeShellBridge = NativeShellBridge();

  List<Widget> get _screens => [
        NewHomeScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        ProfileScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        Container(),
        PayEmiScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        MenuScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
        ChatScreen(
          isEmbedded: widget.isEmbedded,
          useNativeShell: widget.useNativeShell,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, _screens.length - 1).toInt();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        }
        return false;
      },
      child: Scaffold(
        body: _currentIndex == 2
            ? NewHomeScreen(
                isEmbedded: widget.isEmbedded,
                useNativeShell: widget.useNativeShell,
              )
            : _screens[_currentIndex],
        bottomNavigationBar: widget.isEmbedded || widget.useNativeShell
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScanQRScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    } else if (widget.useNativeShell &&
                        (index == 4 || index == 5)) {
                      _nativeShellBridge.openFeature(
                        index == 4 ? 'menu' : 'chat',
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
      ),
    );
  }
}
