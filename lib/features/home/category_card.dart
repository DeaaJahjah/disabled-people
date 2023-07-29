import 'package:disaoled_people/config/constants/constant.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final List<Color> colors;
  final String title;
  final String image;
  final String routName;
  const CategoryCard({Key? key, required this.colors, required this.image, required this.title, required this.routName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(routName),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: colors)),
        child: Column(
          children: [
            Image.asset(
              image,
              width: 100,
              height: 100,
            ),
            sizedBoxMedium,
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
