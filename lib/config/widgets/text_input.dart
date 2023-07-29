import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextInput extends StatelessWidget {
  final String icon;
  final String labelText;
  final TextEditingController controller;
  TextInputType? keyboardType;
  int? maxLines = 1;
  int? minLines;
  bool? readOnly = false;
  final Function()? onTap;
  TextInput(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.keyboardType,
      this.maxLines,
      this.minLines,
      this.onTap,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: white),
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      minLines: minLines,
      validator: (value) {
        if (value!.isEmpty) return 'الحقل مطلوب';

        return null;
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: icon != ''
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    icon,
                  ),
                )
              : const SizedBox.shrink(),
          labelText: labelText),
      onTap: onTap,
    );
  }
}
