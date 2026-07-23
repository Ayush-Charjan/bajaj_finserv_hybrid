import 'dart:convert';
import 'dart:math' as math;
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
      'https://raw.githubusercontent.com/Ayush-Charjan/bajaj_finserv_hybrid/main/bajaj_finserv_hybrid/assets/sdui/mandate.json';

  late Future<Map<String, dynamic>> _jsonFuture;

  @override
  void initState() {
    super.initState();
    _jsonFuture = _fetchJson();
  }

  Future<Map<String, dynamic>> _fetchJson() async {
    final uri = Uri.parse(
      '$_mandateJsonUrl?v=${DateTime.now().millisecondsSinceEpoch}',
    );
    final response = await http.get(uri);
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
            body: Center(child: _BankLoadingAnimation()),
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

/// ---------------------------------------------------------------------------
/// FUN LOADING ANIMATION SHOWN WHILE THE NATIVE SHELL FETCHES THE SDUI SCREEN
/// ---------------------------------------------------------------------------
class _BankLoadingAnimation extends StatefulWidget {
  const _BankLoadingAnimation();

  @override
  State<_BankLoadingAnimation> createState() => _BankLoadingAnimationState();
}

class _BankLoadingAnimationState extends State<_BankLoadingAnimation>
    with TickerProviderStateMixin {
  static const Color _navy = Color(0xFF002A54);
  static const Color _orange = Color(0xFFFF6B35);

  late final AnimationController _orbitController;
  late final AnimationController _cardController;
  late final AnimationController _captionController;

  final List<String> _captions = const [
    'Verifying your details…',
    'Talking to the bank…',
    'Almost there…',
  ];
  int _captionIndex = 0;

  @override
  void initState() {
    super.initState();

    // Coin orbiting around the card, continuous.
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    // Card gently tilting back and forth, like it's being flipped to read.
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    // Rotates through the caption strings underneath.
    _captionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _captionController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          _captionIndex = (_captionIndex + 1) % _captions.length;
        });
        _captionController.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _cardController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          width: 120,
          child: AnimatedBuilder(
            animation: Listenable.merge([_orbitController, _cardController]),
            builder: (context, child) {
              final orbitAngle = _orbitController.value * 2 * 3.14159265;
              final tilt =
                  (_cardController.value - 0.5) * 0.35; // radians, subtle

              return Stack(
                alignment: Alignment.center,
                children: [
                  // Soft pulsing halo behind everything.
                  Transform.scale(
                    scale: 0.9 + (0.1 * _cardController.value),
                    child: Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _navy.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  // The bank card, tilting like it's being handed over.
                  Transform.rotate(
                    angle: tilt,
                    child: Container(
                      height: 54,
                      width: 82,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [_navy, Color(0xFF0A4A8C)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _navy.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 8,
                              width: 14,
                              decoration: BoxDecoration(
                                color: _orange,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 3,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // A little coin orbiting the card.
                  Transform.translate(
                    offset: Offset(
                      38 * math.cos(orbitAngle),
                      16 * math.sin(orbitAngle),
                    ),
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _orange,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: _orange.withValues(alpha: 0.4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '₹',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            _captions[_captionIndex],
            key: ValueKey(_captionIndex),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _navy,
            ),
          ),
        ),
      ],
    );
  }
}
