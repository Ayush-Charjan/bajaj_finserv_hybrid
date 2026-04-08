import 'dart:html' as html;

class NativeFooterBridge {
  void Function(html.Event event)? _listener;

  void register(void Function(int index) onTap) {
    _listener = (html.Event event) {
      final dynamic detail = (event as dynamic).detail;
      final dynamic rawIndex =
          detail is Map ? detail['index'] : (detail as dynamic)?.index;
      if (rawIndex is num) {
        onTap(rawIndex.toInt());
      }
    };
    html.window.addEventListener('nativeFooterTap', _listener);
  }

  void dispose() {
    if (_listener != null) {
      html.window.removeEventListener('nativeFooterTap', _listener);
      _listener = null;
    }
  }
}
