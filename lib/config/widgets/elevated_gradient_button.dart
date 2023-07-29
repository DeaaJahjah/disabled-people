import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class ElevatedGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const ElevatedGradientButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(color: white, fontFamily: font, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
