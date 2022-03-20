import 'package:flutter/material.dart';
import 'package:zione/features/agenda/ui/widgets/entry_form/components/input_text.dart';

Widget buildInput(String label, TextInputType inputType, valueToSave) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
    child: TextFormField(
      keyboardType: inputType,
      decoration: customInputDecoration(label),
      onSaved: (value) {
        if (value != null) {
          valueToSave = value;
        }
      },
    ),
  );
}
