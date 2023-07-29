import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/profile/screens/charity_profile_screen.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Charity item;
  final int colorIndex;
  final Function onTap;

  const CardWidget({Key? key, required this.item, required this.colorIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CharityProfileScreen.routeName, arguments: item.id);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.36,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                    color: getColor(colorIndex),
                    border: Border.all(
                      color: getColor(colorIndex),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: MediaQuery.of(context).size.height * 0.19,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              item.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Center(
                            child: Text(
                              item.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: getColor(colorIndex),
                    radius: 60,
                    child: CircleAvatar(
                      radius: 58,
                      backgroundImage: NetworkImage(item.image!),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(int colorIndex) {
    if (colorIndex == 1) {
      return secondaryColor;
    } else if (colorIndex == 0) {
      return orange;
    }

    return white;
  }
}
