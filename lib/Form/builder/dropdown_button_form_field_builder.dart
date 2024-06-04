import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class DropdownButtonFormFieldBuilder extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final List<String> options;
  final bool multi;
  final Map data;
  final String datakey;

  DropdownButtonFormFieldBuilder({
    required this.label,
    required this.hint,
    required this.isRequired,
    required this.options,
    required this.multi,
    required this.data,
    required this.datakey,
  });

  @override
  _DropdownButtonFormFieldBuilderState createState() =>
      _DropdownButtonFormFieldBuilderState();
}

class _DropdownButtonFormFieldBuilderState
    extends State<DropdownButtonFormFieldBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.multi) {
      case true:
        return MultiSelectDialogField(
          onSaved: (value) {
            widget.data[widget.datakey] = value;
          },
          items: widget.options.map((e) => MultiSelectItem(e, e)).toList(),
          title: Text(widget.label),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(10.0),
          ),
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: Text(widget.hint),
          onConfirm: (values) {},
          validator: widget.isRequired
              ? (values) {
                  if (values == null || values.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );

      case false:
        return DropdownButtonFormField<String>(
          onSaved: (value) {
            widget.data[widget.datakey] = value;
          },
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          isExpanded: true,
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            );
          }).toList(),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
          onChanged: (String? value) {},
        );

      default:
        throw Exception('Unsupported dropdown type');
    }
  }

  @override
  bool get wantKeepAlive => true;
}
