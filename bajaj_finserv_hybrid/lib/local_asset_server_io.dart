import 'dart:io';
import 'package:flutter/services.dart';

class LocalAssetServer {
  HttpServer? _server;

  String? get url =>
      _server == null ? null : 'http://127.0.0.1:${_server!.port}';

  Future<void> start() async {
    if (_server != null) {
      return;
    }

    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server!.listen(_handleRequest);
  }

  Future<void> _handleRequest(HttpRequest request) async {
    final String path = _normalizePath(request.uri.path);
    final String assetPath = 'assets/webapp/$path';

    try {
      final ByteData data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      final contentType = _contentTypeFor(path);

      if (contentType != null) {
        request.response.headers.contentType = contentType;
      }
      request.response.add(bytes);
      await request.response.close();
    } catch (_) {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('Not found: $assetPath');
      await request.response.close();
    }
  }

  String _normalizePath(String path) {
    if (path.isEmpty || path == '/') {
      return 'index.html';
    }

    final normalized = path.startsWith('/') ? path.substring(1) : path;
    if (normalized.contains('..')) {
      return 'index.html';
    }
    return normalized;
  }

  ContentType? _contentTypeFor(String path) {
    final lower = path.toLowerCase();
    if (lower.endsWith('.html')) return ContentType.html;
    if (lower.endsWith('.js')) return ContentType('application', 'javascript');
    if (lower.endsWith('.json')) return ContentType.json;
    if (lower.endsWith('.css')) return ContentType('text', 'css');
    if (lower.endsWith('.png')) return ContentType('image', 'png');
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) {
      return ContentType('image', 'jpeg');
    }
    if (lower.endsWith('.webp')) return ContentType('image', 'webp');
    if (lower.endsWith('.svg')) return ContentType('image', 'svg+xml');
    if (lower.endsWith('.wasm')) {
      return ContentType('application', 'wasm');
    }
    if (lower.endsWith('.ttf')) {
      return ContentType('font', 'ttf');
    }
    return null;
  }

  void close() {
    _server?.close(force: true);
    _server = null;
  }
}
