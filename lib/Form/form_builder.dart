import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/form/builder/checkbox_builder.dart';
import 'package:test_app/form/builder/date_picker_builder.dart';
import 'package:test_app/form/builder/dropdown_button_form_field_builder.dart';
import 'package:test_app/form/builder/recognition_button.dart';
import 'package:test_app/form/builder/text_form_field_builder.dart';
import 'package:test_app/form/builder/picture_builder.dart';
import 'package:test_app/form/builder/time_picker_builder.dart';
import 'package:test_app/form/builder/date_time_picker_builder.dart';
import 'package:test_app/form/builder/notice_builder.dart';

Future<List<Widget>> buildFormFromJson(
    BuildContext context, String pathToJson, Map<String, dynamic> values) async {
  String jsonData = await rootBundle.loadString(pathToJson);
  Map<String, dynamic> formData = jsonDecode(jsonData);

  List<Widget> formWidgets = [];

  List<dynamic> formFields = formData['form'];
  int idgen = 0;

  for (var field in formFields) {
    String widgetType = field['field_type'] ?? '';
    String widgetLabel = field['field_label'] ?? '';
    String widgetHint = field['field_hint'] ?? '';
    bool isRequired = field['field_required'] ?? false;
    String widgetKeyboardType = field['input_type'] ?? '';
    bool dropDownMulti = field['max_choices'] ?? false;
    String specietype = field['specie_type'] ?? '';
    String keyvalue = field[''] ?? idgen.toString(); // Key attribut for the data / To store in BDD (Need to be implement in JSON)

    // incremente the idgen
    idgen++;
    
    // Construire les widgets en fonction du type de champ
    switch (widgetType) {
      case 'input':
        formWidgets.add(buildTextFormField(
            widgetLabel, widgetHint, isRequired, widgetKeyboardType, values, keyvalue ));
        break;
      case 'select':
        List<dynamic> options = field['select_options'];
        List<String> stringList =
            options.map((option) => option['label'].toString()).toList();
        formWidgets.add(buildDropdownButtonFormField(
            widgetLabel, widgetHint, isRequired, stringList, dropDownMulti, values, keyvalue));
        break;
      case 'checkbox':
      //TODO: Make the possibility Required
        formWidgets.add(MyCheckbox(label: widgetLabel, data: values, datakey: keyvalue,));
        break;
      case 'datepicker':
        formWidgets.add(DatePickerWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired, data: values, datakey: keyvalue,));
        break;
      case 'picturepicker':
      //TODO: Make the possibility Required
        formWidgets.add(PictureWidget(data: values, datakey: 'image'));
        break;
      case 'timepicker':
        formWidgets.add(TimeWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired, data: values, datakey: keyvalue,));
        break;
      case 'datetimepicker':
        formWidgets.add(DateTimeWidget(
            label: widgetLabel, hint: widgetHint, isRequired: isRequired, data: values, datakey: keyvalue,));
        break;
      case 'notice':
        formWidgets.add(NoticeWidget(label: widgetLabel));
        break;
      case 'recognition':
      //TODO: Make the possibility Required Only for the picture (Recognition is a feature)
        formWidgets.add(RecognitionButton(type: specietype, datakey: keyvalue, data: values,));
      default:
        throw Exception('Unsupported widget type: $widgetType');
    }
  };

  return formWidgets;
}
