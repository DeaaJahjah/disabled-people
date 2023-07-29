import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/auth/screens/create_benefactor_account_screen.dart';
import 'package:disaoled_people/features/auth/screens/create_chirity_account_screen.dart';
import 'package:disaoled_people/features/auth/screens/create_pationt_account_screen.dart';
import 'package:flutter/material.dart';

class SelectAccountTypeScreen extends StatefulWidget {
  static const routeName = '/select-account-type';
  const SelectAccountTypeScreen({super.key});

  @override
  State<SelectAccountTypeScreen> createState() =>
      _SelectAccountTypeScreenState();
}

class _SelectAccountTypeScreenState extends State<SelectAccountTypeScreen> {
  int selectedType = -1;
  @override
  Widget build(BuildContext context) {
    final types = ['مريض', 'متبرع', 'جمعية'];
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('اختر نوع الحساب',
                  style: Theme.of(context).textTheme.headlineLarge),
              sizedBoxLarge,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      secondaryColor,
                    ],
                  ),
                ),
                child: Column(children: [
                  SelectTypeWidget(
                    title: types[0],
                    isSelected: 1 == selectedType,
                    onTap: () {
                      setState(() {});
                      selectedType = 1;
                    },
                  ),
                  SelectTypeWidget(
                    title: types[1],
                    isSelected: 2 == selectedType,
                    onTap: () {
                      setState(() {});
                      selectedType = 2;
                    },
                  ),
                  SelectTypeWidget(
                    title: types[2],
                    isSelected: 3 == selectedType,
                    onTap: () {
                      setState(() {});
                      selectedType = 3;
                    },
                  ),
                ]),
              ),
              ElevatedGradientButton(
                  onPressed: () {
                    if (selectedType == 1) {
                      Navigator.of(context)
                          .pushNamed(CreatePationtAccountScreen.routeName);
                      return;
                    }
                    if (selectedType == 2) {
                      Navigator.of(context)
                          .pushNamed(CreateBenefactorAccountScreen.routeName);
                      return;
                    }

                    if (selectedType == 3) {
                      Navigator.of(context)
                          .pushNamed(CreateChirityAccountScreen.routeName);
                      return;
                    }
                  },
                  text: 'التالي')
            ],
          )),
    );
  }
}

//select Type Widget
class SelectTypeWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isSelected;
  const SelectTypeWidget(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected ? secondaryColor : whitWithOpacity,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
