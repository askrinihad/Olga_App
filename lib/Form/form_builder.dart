import 'package:flutter/material.dart';
import 'package:test_app/BDD/bdd_function.dart';
import 'package:test_app/Form/builder/dropdown_button_form_field_builder.dart';
import 'package:test_app/Form/builder/text_form_field_builder.dart';
import 'package:test_app/form/builder/checkbox_builder.dart';
import 'package:test_app/form/builder/date_picker_builder.dart';
import 'package:test_app/form/builder/recognition_button.dart';
import 'package:test_app/form/builder/picture_builder.dart';
import 'package:test_app/form/builder/time_picker_builder.dart';
import 'package:test_app/form/builder/date_time_picker_builder.dart';
import 'package:test_app/form/builder/notice_builder.dart';
import 'package:test_app/form/builder/geoloc_builder.dart';

/// Fonction for build all Widget from Json forms.
///
/// Must return List of dynamic and not List of Widget because picture_widget implement a update method that can't be used if this function return Widget type. 
/// It's weird, maybe you can fix that by a refactor, if you try : Good Luck!
Future<List<dynamic>> buildFormFromJson(BuildContext context,
    Map<String, dynamic> values, String airport, Map<String, dynamic> formData,
    {String? specie_type}) async {
  List<Widget> formWidgets = [];

  List<dynamic> formFields = formData['form'];
  int idgen = 0;

  for (var field in formFields) {
    String widgetType = field['field_type'] ?? '';
    String widgetLabel = field['field_label'] ?? '';
    String widgetHint = field['field_hint'] ?? '';
    bool isRequired = field['field_required'] ?? false;
    String widgetKeyboardType = field['input_type'] ?? '';
    String keyvalue = field['field_key'] ??
        idgen
            .toString(); // Key attribut for the data / To store in BDD (Need to be implement in JSON)

    // incremente the idgen
    idgen++;

    // Construire les widgets en fonction du type de champ
    switch (widgetType) {
      case 'input':
        formWidgets.add(TextFormFieldBuilder(
            label: widgetLabel,
            hint: widgetHint,
            isRequired: isRequired,
            keyboardType: widgetKeyboardType,
            data: values,
            dataKey: keyvalue));
        break;
      case 'select':
        List<String> stringList = [];
        String source = field['select_source'] ?? '';
        switch (source) {
          case "species":
            stringList = await getSpecie(airport: airport, type: specie_type);
            break;
          case "code_inventory":
            stringList = await getInventoryCode(airport);
            break;
          default:
            List<dynamic> options = field['select_options'] ?? [];
            stringList =
                options.map((option) => option['label'].toString()).toList();
        }
        bool dropDownMulti = field['select_multi'] ?? false;
        formWidgets.add(DropdownButtonFormFieldBuilder(
          label: widgetLabel,
          hint: widgetHint,
          isRequired: isRequired,
          options: stringList,
          multi: dropDownMulti,
          data: values,
          datakey: keyvalue,
        ));
        ;
        break;
      case 'checkbox':
        //TODO: Make the possibility Required
        formWidgets.add(MyCheckbox(
          label: widgetLabel,
          data: values,
          datakey: keyvalue,
        ));
        break;
      case 'datepicker':
        formWidgets.add(DatePickerWidget(
          label: widgetLabel,
          hint: widgetHint,
          isRequired: isRequired,
          data: values,
          datakey: keyvalue,
        ));
        break;
      case 'picturepicker':
        //TODO: Make the possibility Required
        formWidgets.add(PictureWidget(data: values, datakey: 'image'));
        break;
      case 'timepicker':
        //TODO: Make by default Datetime.now()
        formWidgets.add(TimeWidget(
          label: widgetLabel,
          hint: widgetHint,
          isRequired: isRequired,
          data: values,
          datakey: keyvalue,
        ));
        break;
      case 'datetimepicker':
        //TODO: Make by default Datetime.now()
        formWidgets.add(DateTimeWidget(
          label: widgetLabel,
          hint: widgetHint,
          isRequired: isRequired,
          data: values,
          datakey: keyvalue,
        ));
        break;
      case 'notice':
        formWidgets.add(NoticeWidget(label: widgetLabel));
        break;
      case 'location':
        formWidgets.add(LocationWidget(
          label: 'Location',
          stopLocation: 0,
        ));
        break;
      case 'recognition':
        bool saveScore = field['field_saveScore'] ?? true;
        bool showScore = field['field_showScore'] ?? true;
        bool saveSpecie = field['field_saveScore'] ?? true;

        formWidgets.add(RecognitionButton(
            type: specie_type,
            data: values,
            datakey: 'predicted_specie',
            datakeyScore: 'score',
            saveScore: saveScore,
            showScore: showScore,
            saveSpecie: saveSpecie));
      default:
        throw Exception('Unsupported widget type: $widgetType');
    }
  }
  ;

  return formWidgets;
}
