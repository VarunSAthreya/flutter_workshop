import 'package:flutter/material.dart';

class CustomTextFrom extends StatelessWidget {
  const CustomTextFrom({
    Key? key,
    required this.title,
    required this.icon,
    required this.onChnage,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function onChnage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: title,
        labelText: title,
        icon: Icon(icon),
      ),
      onChanged: (String value) => onChnage(value),
    );
  }
}
