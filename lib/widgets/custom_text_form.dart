import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String title;
  final String initialValue;
  final IconData icon;
  final Function onChange;

  const CustomTextForm({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.icon,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: title,
        labelText: title,
        icon: Icon(icon),
      ),
      onChanged: (String value) => onChange(value),
    );
  }
}
