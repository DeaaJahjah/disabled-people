
import 'package:disaoled_people/config/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunicationSection extends StatelessWidget {
  final String phoneNum;
  final String email;
  const CommunicationSection({Key? key,required this.email,required this.phoneNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
          Padding(
              padding: const EdgeInsets.only(top: 30, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 10),
                  Text(phoneNum,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    width: 16,
                  ),
                  
                  SvgPicture.asset(
                    'assets/icons/callPink.svg',
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
                  Text(email,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    width: 16,
                  ),
                  SvgPicture.asset(
                    'assets/icons/pinkEmail.svg',
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