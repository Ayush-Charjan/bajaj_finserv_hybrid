import 'dart:html' as html;

bool isLikelyEmbeddedRuntime() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  final looksLikeWebView = userAgent.contains('; wv') ||
      userAgent.contains(' webview') ||
      userAgent.contains('fbav');

  bool inIframe = false;
  try {
    inIframe = html.window != html.window.top;
  } catch (_) {
    inIframe = true;
  }

  return looksLikeWebView || inIframe;
}
