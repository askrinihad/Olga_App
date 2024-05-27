import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class TextFormFieldBuilder extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final String keyboardType;
  final Map data;
  final String dataKey;

  TextFormFieldBuilder({
    required this.label,
    required this.hint,
    required this.isRequired,
    required this.keyboardType,
    required this.data,
    required this.dataKey,
  });

  @override
  _TextFormFieldBuilderState createState() => _TextFormFieldBuilderState();
}

class _TextFormFieldBuilderState extends State<TextFormFieldBuilder> with AutomaticKeepAliveClientMixin {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (widget.keyboardType) {
      case 'text':
        return TextFormField(
          controller: _controller,
          onSaved: (value) {
            widget.data[widget.dataKey] = value;
          },
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );
      case 'decimal':
        return TextFormField(
          controller: _controller,
          onSaved: (value) {
            widget.data[widget.dataKey] = value;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*([.,]\d*)?$')),
          ],
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );
      case 'integer':
        return TextFormField(
          controller: _controller,
          onSaved: (value) {
            widget.data[widget.dataKey] = value;
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
          ],
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );
      case 'email':
        return TextFormField(
          controller: _controller,
          onSaved: (value) {
            widget.data[widget.dataKey] = value;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                }
              : null,
        );

      case 'notes':
        return TextFormField(
          controller: _controller,
          onSaved: (value) {
            widget.data[widget.dataKey] = value;
          },
          maxLines: 8,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          validator: widget.isRequired
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est obligatoire';
                  }
                  return null;
                }
              : null,
        );

      default:
        throw Exception('Unsupported keyboardType: ${widget.keyboardType}');
    }
  }
  
  @override
  bool get wantKeepAlive => true;
}