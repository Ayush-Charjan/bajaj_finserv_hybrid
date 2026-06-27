import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:flutter/services.dart';

class StacEmiScreen extends StatelessWidget {
  const StacEmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString('assets/sdui/insta_emi_card.json'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Failed to load UI: ${snapshot.error}')),
          );
        }
        if (snapshot.hasData) {
          try {
            return Stac.fromJson(snapshot.data!, context) ?? const Scaffold(body: Center(child: Text('Invalid JSON')));
          } catch (e) {
             return Scaffold(
              appBar: AppBar(title: const Text('Parsing Error')),
              body: Center(child: Text('Error parsing SDUI: $e')),
            );
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
