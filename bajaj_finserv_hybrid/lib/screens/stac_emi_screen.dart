import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:flutter/services.dart';

class StacEmiScreen extends StatelessWidget {
  const StacEmiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Building StacEmiScreen...');
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
            debugPrint('Rendering SDUI from JSON...');
            final widget = Stac.fromJson(snapshot.data!, context);
            if (widget == null) {
              return const Scaffold(body: Center(child: Text('Stac failed to parse JSON')));
            }
            return widget;
          } catch (e, stack) {
             debugPrint('Error parsing SDUI: $e\n$stack');
             return Scaffold(
              appBar: AppBar(title: const Text('Parsing Error'), backgroundColor: Colors.red),
              body: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(16), child: Text('Error parsing SDUI: $e'))),
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
