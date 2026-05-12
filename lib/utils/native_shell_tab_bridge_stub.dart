import 'dart:async';

class NativeShellTabBridge {
  NativeShellTabBridge._();

  static final NativeShellTabBridge instance = NativeShellTabBridge._();

  Stream<int> get stream => const Stream<int>.empty();
}
