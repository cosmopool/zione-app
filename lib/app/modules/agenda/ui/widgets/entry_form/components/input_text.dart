import 'package:flutter/material.dart';

customInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2),
    ),
  );
}

Widget customFormField(String label, widgetProperty, TextInputType? textType) {
  TextInputType? _textType;

  if (textType == null) {
    _textType = TextInputType.text;
  } else {
    _textType = textType;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    child: TextFormField(
      keyboardType: _textType,
      decoration: customInputDecoration(label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preencha esse campo';
        }
      },
      onSaved: (value) {
        widgetProperty = value;
      },
    ),
  );
}
