import 'package:flutter/material.dart';

import 'app_text_style.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?> onChanged;
  final String hintText;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ),
        ),
        hintText: hintText,
      ),
      value: value,
      items: items
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: AppTextStyle(text: item),
        ),
      )
          .toList(),
      onChanged: onChanged,
      icon: Icon(Icons.arrow_drop_down, color: Colors.red),
    );
  }
}
