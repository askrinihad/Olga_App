import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/form/builder/checkbox_builder.dart';
import 'package:test_app/form/builder/date_picker_builder.dart';
import 'package:test_app/form/builder/dropdown_button_form_field_builder.dart';
import 'package:test_app/form/builder/recognition_button.dart';
import 'package:test_app/form/builder/text_form_field_builder.dart';
import 'package:test_app/form/builder/picture_builder.dart';
import 'package:test_app/form/builder/time_pikcer_builder.dart';
import 'package:test_app/form/builder/date_time_picker_builder.dart';
import 'package:test_app/form/builder/notice_builder.dart';

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
    String specietype = field['specie_type'] ?? '';

    // Construire les widgets en fonction du type de champ
    switch (widgetType) {
      case 'input':
        formWidgets.add(buildTextFormField(
            widgetLabel, widgetHint, isRequired, widgetKeyboardType));
        break;
      case 'select':
        List<dynamic> options = field['select_options'];
        List<String> stringList =
            options.map((option) => option['label'].toString()).toList();
        formWidgets.add(buildDropdownButtonFormField(
            widgetLabel, widgetHint, isRequired, stringList, dropDownMulti));
        break;
      case 'checkbox':
      //TODO: Make the possibility Required
        formWidgets.add(MyCheckbox(label: widgetLabel));
        break;
      case 'datepicker':
        formWidgets.add(DatePickerWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired));
        break;
      case 'picturepicker':
      //TODO: Make the possibility Required
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
      case 'recognition':
      //TODO: Make the possibility Required Only for the picture (Recognition is a feature)
        formWidgets.add(RecognitionButton(type: specietype));
      default:
        throw Exception('Unsupported widget type: $widgetType');
    }
  });

  return formWidgets;
}
