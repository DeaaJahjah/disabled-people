import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: secondaryColor,
    ));
  }
}
