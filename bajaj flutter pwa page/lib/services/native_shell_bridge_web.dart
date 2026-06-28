import 'dart:html' as html;

class NativeShellBridge {
  void openFeature(String feature) {
    html.window.location.assign('native://$feature');
  }
}
