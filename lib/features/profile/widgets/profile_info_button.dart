import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';
class ProfileInfoButton extends StatelessWidget {
  final String text;
  final bool isPressed;
  final VoidCallback? onPressed;
  ProfileInfoButton(
      {Key? key,
      required this.text,
      required this.isPressed,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 6, bottom: 6),
        decoration: BoxDecoration(
          border: Border.all(color: orange, width: 2),
          borderRadius: BorderRadius.circular(30),
          color: isPressed ? orange : white,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isPressed ? white : orange,
              fontFamily: font,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
