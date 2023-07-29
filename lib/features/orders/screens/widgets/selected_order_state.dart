import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class SelectOrderState extends StatelessWidget {
  const SelectOrderState(
      {super.key, required this.title, required this.state, required this.onTap, required this.selected});

  final String title;
  final OrderState state;
  final bool selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(10),
            color: !selected ? Colors.transparent : null,
            gradient: selected
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  )
                : null),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: selected ? white : primaryColor),
        ),
      ),
    );
  }
}
