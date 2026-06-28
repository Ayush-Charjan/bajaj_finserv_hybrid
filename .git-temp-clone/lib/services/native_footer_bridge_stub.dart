class NativeFooterBridge {
  void register(void Function(int index) onTap) {
    // No-op on non-web platforms.
  }

  void dispose() {
    // No-op on non-web platforms.
  }
}
