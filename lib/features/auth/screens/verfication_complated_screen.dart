import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class VerficationComplateScreen extends StatelessWidget {
  static const routeName = '/verfication-complated';

  const VerficationComplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
      },
    );
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBoxLarge,
              Image.asset(
                "assets/images/shaild.png",
              ),
              sizedBoxLarge,
              Text('تم تأكيد الحساب بنجاح\n اهلا بك في مجتمعنا',
                  style: Theme.of(context).textTheme.displayLarge, textAlign: TextAlign.center),
            ],
          )),
    );
  }
}
