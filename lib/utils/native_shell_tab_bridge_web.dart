import 'dart:async';
import 'dart:html' as html;

class NativeShellTabBridge {
  NativeShellTabBridge._() {
    html.window.addEventListener('nativeShellTab', _handleNativeShellTab);
  }

  static final NativeShellTabBridge instance = NativeShellTabBridge._();

  final StreamController<int> _tabController =
      StreamController<int>.broadcast();

  Stream<int> get stream => _tabController.stream;

  void _handleNativeShellTab(html.Event event) {
    final dynamic detail = (event as html.CustomEvent).detail;
    final String tab = detail?.toString() ?? '';
    final int index = _tabToIndex(tab);
    _tabController.add(index);
  }

  int _tabToIndex(String tab) {
    switch (tab.toLowerCase().trim()) {
      case 'profile':
        return 1;
      case 'scan':
      case 'scanqr':
      case 'scan-qr':
        return 2;
      case 'payemi':
      case 'pay':
        return 3;
      case 'menu':
        return 4;
      case 'chat':
        return 5;
      case 'home':
      default:
        return 0;
    }
  }
}
