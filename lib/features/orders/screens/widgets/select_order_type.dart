import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:flutter/material.dart';

class SelectOrderType extends StatelessWidget {
  const SelectOrderType(
      {super.key, required this.title, required this.type, required this.onTap, required this.selected});

  final String title;
  final OrderType type;
  final bool selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    // OrderDbService().addPost(
    //     OrderModle(
    //         id: "",
    //         description: 'وصف عن هذا الموضوع',
    //         location: 'location',
    //         orderType: OrderType.benefit,
    //         orderState: OrderState.available,
    //         ownerId: context.userUid!,
    //         ownerPic: context.currentUserImage!,
    //         reciverId: null,
    //         images: const [
    //           'https://play-lh.googleusercontent.com/06BCcW6rW0Lh0f8Wa51IJPuAfXzmmVmj6ip6r9whuRgG-dJQjBdytmZ0K1EMxF8CGy4',
    //         ],
    //         deliverdTime: null,
    //         ownerName: 'علي آلاء'),
    //     context);
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
