import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stac/stac.dart';

class StacMandateScreen extends StatefulWidget {
  const StacMandateScreen({super.key});

  @override
  State<StacMandateScreen> createState() => _StacMandateScreenState();
}

class _StacMandateScreenState extends State<StacMandateScreen> {
  static const String _mandateJsonUrl =
      'https://raw.githubusercontent.com/Ayush-Charjan/bajaj_finserv_hybrid/main/bajaj_finserv_hybrid/assets/sdui/change_bank_account.json';

  late Future<Map<String, dynamic>> _jsonFuture;

  @override
  void initState() {
    super.initState();
    _jsonFuture = _fetchJson();
  }

  Future<Map<String, dynamic>> _fetchJson() async {
    final response = await http.get(Uri.parse(_mandateJsonUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to load screen JSON (Code: ${response.statusCode})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _jsonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF5F7FA),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF002A54)),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FA),
            appBar: AppBar(
              backgroundColor: const Color(0xFF002A54),
              title: const Text(
                'Change Bank Account',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Failed to load Mandate screen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6B35),
                      ),
                      onPressed: () {
                        setState(() {
                          _jsonFuture = _fetchJson();
                        });
                      },
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return Stac.fromJson(snapshot.data!, context) ??
              const SizedBox.shrink();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
