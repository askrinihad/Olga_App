import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:test_app/form/form_builder.dart';

void main() {
  testWidgets('buildFormFromJson test', (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: Scaffold()));

    final BuildContext context = tester.element(find.byType(Scaffold));

    const String json = '''
    {
      "form_id": "example_form_1",
      "form_label": "Example Form 1",
      "form_version": "0.1.0",
      "form": [
        {
          "field_type": "notice",
          "field_label": "Ceci est un text"
        },
        {
          "field_type": "picturepicker",
          "field_label": "selectionner une photo",
          "field_required": true
        },
        {
          "field_type": "input",
          "field_label": "This text",
          "field_hint": "text hint",
          "field_required": true,
          "input_type": "text",
          "input_default": "",
          "input_min": 1,
          "input_max": 100
        }
      ]
    }
    ''';

    final File file = File('test.json');
    await file.writeAsString(json);

    final List<Widget> widgets = await buildFormFromJson(context, 'test.json');

    expect(widgets.length, 3);
  });
}