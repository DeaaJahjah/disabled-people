import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const EditButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 230,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, secondaryColor])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('تعديل المعلومات',
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              'assets/icons/editIcon.svg',
              width: 25,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
