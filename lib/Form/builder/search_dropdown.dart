import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchDropdown extends StatefulWidget {
  final String label;
  final String hint;
  final bool isRequired;
  final List<String> options;
  final bool multi;
  final Map data;
  final String datakey;

  SearchDropdown({
    required this.label,
    required this.hint,
    required this.isRequired,
    required this.options,
    required this.multi,
    required this.data,
    required this.datakey,
  });

  @override
  State<StatefulWidget> createState() {
    return _SearchDropdownState();
  }
}

class _SearchDropdownState extends State<SearchDropdown> {
  @override
  Widget build(BuildContext context) {
    if (widget.multi) {
      return DropdownSearch<String>.multiSelection(
        items: widget.options,
        onChanged: print,
        selectedItems: [],
        onSaved: (value) {
          widget.data[widget.datakey] = value;
        },
        validator: (List<String>? value) {
          if (widget.isRequired && value!.isEmpty) {
            return 'Ce champ est obligatoire';
          } else {
            return null;
          }
        },
        popupProps: PopupPropsMultiSelection.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchDelay: Duration(milliseconds: 500),
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Search ...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
          )),
          menuProps: MenuProps(
            backgroundColor: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(10),
            elevation: 5,
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            filled: true,
            fillColor: Color(0xFFF8F8F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey.shade600,
                width: 1.0,
              ),
            ),
          ),
        ),
      );
    }
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        showSearchBox: true,
      ),
      items: widget.options,
      onChanged: print,
      onSaved: (value) {
        widget.data[widget.datakey] = value;
      },
      validator: (String? value) {
        if (widget.isRequired && value == null) {
          return 'Ce champ est obligatoire';
        } else {
          return null;
        }
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          filled: true,
          fillColor: Color(0xFFF8F8F8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
