import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/builder/checkbox_builder.dart';
import 'package:test_app/builder/date_picker_builder.dart';
import 'package:test_app/builder/dropdown_button_form_field_builder.dart';
import 'package:test_app/builder/text_form_field_builder.dart';
import 'package:test_app/builder/picture_builder.dart';
import 'package:test_app/builder/time_pikcer_builder.dart';
import 'package:test_app/builder/date_time_picker_builder.dart';
import 'package:test_app/builder/notice_builder.dart';

Future<List<Widget>> buildFormFromJson(
  BuildContext context, String pathToJson) async {
  String jsonData = await rootBundle.loadString(pathToJson);
  Map<String, dynamic> formData = jsonDecode(jsonData);

  List<Widget> formWidgets = [];

  List<dynamic> formFields = formData['form'];

  formFields.forEach((field) {
    String widgetType = field['field_type'] ?? '';
    String widgetLabel = field['field_label'] ?? '';
    String widgetHint = field['field_hint'] ?? '';
    bool isRequired = field['field_required'] ?? false;
    String widgetKeyboardType = field['input_type'] ?? '';
    bool dropDownMulti = field['max_choices'] ?? false;

    // Construire les widgets en fonction du type de champ
    switch (widgetType) {
      case 'input':
        formWidgets.add(buildTextFormField(
            widgetLabel, widgetHint, isRequired, widgetKeyboardType));
        break;
      case 'select':
        List<dynamic> options = field['select_options'];
        List<String> stringList = options.map((option) => option['label'].toString()).toList();
        formWidgets.add(buildDropdownButtonFormField(
            widgetLabel, widgetHint, isRequired, stringList, dropDownMulti));
        break;
      case 'checkbox':
        formWidgets.add(MyCheckbox(label: widgetLabel));
        break;
      case 'datepicker':
        formWidgets.add(DatePickerWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired));
        break;
      case 'picturepicker':
        formWidgets.add(PictureWidget());
        break;
      case 'timepicker':
        formWidgets.add(TimeWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired));
        break;
      case 'datetimepicker':
        formWidgets.add(DateTimeWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired));
          break;
      case 'notice':
        formWidgets.add(NoticeWidget(label: widgetLabel));
        break;
      default:
        throw Exception('Unsupported widget type: $widgetType');
    }
  });

  return formWidgets;
}
