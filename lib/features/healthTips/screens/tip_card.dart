import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class TipCard extends StatelessWidget {
  final String text;
  final Color borderColor;
  final TextStyle textStyle;
  const TipCard({Key? key, required this.text, required this.borderColor, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 6, left: 6),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.5)),
      child: Text(textAlign: TextAlign.right, text, style: textStyle),
    );
  }
}
