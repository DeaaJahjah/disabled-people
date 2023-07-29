import 'package:disaoled_people/config/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoSection extends StatelessWidget {
  final String date;
  final String location;
  const InfoSection({Key? key,required this.date,required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 10),
                  Text(date,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    width: 16,
                  ),
                  
                  SvgPicture.asset(
                    'assets/icons/calenderIcon.svg',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            sizedBoxMedium,
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20,bottom: 40),
              child: Row( mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(location,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    width: 16,
                  ),
                  SvgPicture.asset(
                    'assets/icons/locationIcon.svg',
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
