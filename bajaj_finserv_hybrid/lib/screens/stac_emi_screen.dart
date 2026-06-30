import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class NavigateWithLoaderActionParser
    extends StacActionParser<StacNavigateAction> {
  const NavigateWithLoaderActionParser();

  @override
  String get actionType => 'navigateWithLoader';

  @override
  StacNavigateAction getModel(Map<String, dynamic> json) {
    final modelJson = Map<String, dynamic>.from(json);
    modelJson['actionType'] = ActionType.navigate.name;
    return StacNavigateAction.fromJson(modelJson);
  }

  @override
  Future<dynamic>? onCall(BuildContext context, StacNavigateAction model) {
    Widget? widget;
    if (model.widgetJson != null) {
      widget = Stac.fromJson(model.widgetJson, context);
    } else if (model.request != null) {
      widget = Stac.fromNetwork(
        context: context,
        request: model.request!,
        loadingWidget: (_) => const EmiSduiLoadingScreen(),
        errorWidget: (_, error) => _EmiSduiErrorScreen(error: error),
      );
    } else if (model.assetPath != null) {
      widget = Stac.fromAssets(
        model.assetPath!,
        loadingWidget: (_) => const EmiSduiLoadingScreen(),
        errorWidget: (_, error) => _EmiSduiErrorScreen(error: error),
      );
    }

    switch (model.navigationStyle ?? NavigationStyle.push) {
      case NavigationStyle.push:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
        );
      case NavigationStyle.pushReplacement:
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
          result: model.result,
        );
      case NavigationStyle.pop:
        Navigator.pop(context, model.result);
        return null;
      default:
        return Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => widget ?? const SizedBox()),
        );
    }
  }
}

class PrintFormDataActionParser extends StacActionParser<Map<String, dynamic>> {
  const PrintFormDataActionParser();

  @override
  String get actionType => 'printFormData';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  void onCall(BuildContext context, Map<String, dynamic> model) {
    final ids = (model['ids'] as List?)?.map((id) => id.toString()).toList();
    final formData = StacFormScope.of(context)?.formData ?? {};
    final output = ids == null || ids.isEmpty
        ? Map<String, dynamic>.from(formData)
        : <String, dynamic>{for (final id in ids) id: formData[id] ?? ''};

    debugPrint('[Insta EMI form output] ${jsonEncode(output)}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (routeContext) =>
            Stac.fromJson(_buildResultPageJson(output), routeContext) ??
            const SizedBox(),
      ),
    );
  }

  Map<String, dynamic> _buildResultPageJson(Map<String, dynamic> output) {
    return {
      'type': 'scaffold',
      'backgroundColor': '#F5F7FA',
      'appBar': {
        'type': 'appBar',
        'backgroundColor': '#002A54',
        'foregroundColor': '#FFFFFF',
        'title': {
          'type': 'text',
          'data': 'Application Preview',
          'style': {
            'color': '#FFFFFF',
            'fontSize': 18,
            'fontWeight': 'bold',
          },
        },
      },
      'body': {
        'type': 'singleChildScrollView',
        'padding': {'top': 24, 'left': 16, 'right': 16, 'bottom': 40},
        'child': {
          'type': 'column',
          'crossAxisAlignment': 'start',
          'children': [
            {
              'type': 'container',
              'padding': {'all': 20},
              'decoration': {
                'color': '#FFFFFF',
                'borderRadius': 8,
                'border': {'color': '#D8E1EA', 'width': 1},
              },
              'child': {
                'type': 'column',
                'crossAxisAlignment': 'start',
                'children': [
                  {
                    'type': 'text',
                    'data': 'Submitted details',
                    'style': {
                      'fontSize': 20,
                      'fontWeight': 'bold',
                      'color': '#162B49',
                    },
                  },
                  {'type': 'sizedBox', 'height': 8},
                  {
                    'type': 'text',
                    'data': 'These are the values entered in the SDUI form.',
                    'style': {'fontSize': 12, 'color': '#64748B'},
                  },
                  {'type': 'sizedBox', 'height': 20},
                  _detailRow('Full name', output['fullName']),
                  _detailRow('Mobile number', output['mobile']),
                  _detailRow('PAN number', output['pan']),
                  _detailRow('Date of birth', output['dob']),
                  _detailRow('Employment type', output['employment']),
                  _detailRow('Monthly income', output['income']),
                  _detailRow('Current city', output['city']),
                ],
              },
            },
            {'type': 'sizedBox', 'height': 20},
            {
              'type': 'container',
              'padding': {'all': 18},
              'decoration': {'color': '#EAF3FA', 'borderRadius': 8},
              'child': {
                'type': 'row',
                'crossAxisAlignment': 'start',
                'children': [
                  {
                    'type': 'icon',
                    'icon': 'check_circle_outline',
                    'color': '#16834B',
                    'size': 24,
                  },
                  {'type': 'sizedBox', 'width': 12},
                  {
                    'type': 'expanded',
                    'child': {
                      'type': 'text',
                      'data':
                          'Dummy preview generated from user input. Console output is also printed for debugging.',
                      'style': {'fontSize': 13, 'color': '#334155'},
                    },
                  },
                ],
              },
            },
          ],
        },
      },
    };
  }

  Map<String, dynamic> _detailRow(String label, Object? value) {
    return {
      'type': 'container',
      'margin': {'bottom': 14},
      'padding': {'bottom': 14},
      'child': {
        'type': 'row',
        'crossAxisAlignment': 'start',
        'children': [
          {
            'type': 'expanded',
            'child': {
              'type': 'text',
              'data': label,
              'style': {'fontSize': 12, 'color': '#64748B'},
            },
          },
          {'type': 'sizedBox', 'width': 14},
          {
            'type': 'expanded',
            'child': {
              'type': 'text',
              'data': value?.toString().trim().isNotEmpty == true
                  ? value.toString()
                  : '-',
              'textAlign': 'right',
              'style': {
                'fontSize': 14,
                'fontWeight': 'bold',
                'color': '#162B49',
              },
            },
          },
        ],
      },
    };
  }
}

class StacEmiScreen extends StatefulWidget {
  const StacEmiScreen({super.key});

  @override
  State<StacEmiScreen> createState() => _StacEmiScreenState();
}

class _StacEmiScreenState extends State<StacEmiScreen> {
  late final Future<Map<String, dynamic>> _layout = _loadLayout();

  Future<Map<String, dynamic>> _loadLayout() async {
    final uri = Uri.parse(
      'https://raw.githubusercontent.com/Ayush-Charjan/bajaj_finserv_hybrid/main/bajaj_finserv_hybrid/assets/sdui/insta_emi_card.json?v=${DateTime.now().millisecondsSinceEpoch}',
    );
    final client = HttpClient();
    try {
      final response = await (await client.getUrl(uri)).close();
      if (response.statusCode != HttpStatus.ok) {
        throw HttpException('HTTP ${response.statusCode}', uri: uri);
      }
      final data = jsonDecode(await response.transform(utf8.decoder).join());
      return Map<String, dynamic>.from(_normalize(data) as Map);
    } finally {
      client.close();
    }
  }

  dynamic _normalize(dynamic value) {
    if (value is List) return value.map(_normalize).toList();
    if (value is! Map) return value;

    final result = <String, dynamic>{
      for (final entry in value.entries)
        entry.key.toString(): _normalize(entry.value),
    };
    if (result['type'] == 'text' && result['data'] == null) {
      result['data'] = result.remove('text');
    }
    if (result['type'] == 'image' && result['src'] == null) {
      result['src'] = result.remove('imageUrl');
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _layout,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Failed to load EMI: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const EmiSduiLoadingScreen();
        }
        return Stac.fromJson(snapshot.data!, context) ??
            const Center(child: Text('Failed to render EMI'));
      },
    );
  }
}

class EmiSduiLoadingScreen extends StatelessWidget {
  const EmiSduiLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFFFF6B35)),
            SizedBox(height: 18),
            Text(
              'Loading your offer...',
              style: TextStyle(
                color: Color(0xFF162B49),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmiSduiErrorScreen extends StatelessWidget {
  const _EmiSduiErrorScreen({required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(child: Text('Failed to load: $error')),
    );
  }
}
