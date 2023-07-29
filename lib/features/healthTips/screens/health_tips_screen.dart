import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/utils/shared_pref.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/healthTips/models/tip.dart';
import 'package:disaoled_people/features/healthTips/screens/tip_card.dart';
import 'package:disaoled_people/features/healthTips/services/tips_db_services.dart';
import 'package:disaoled_people/features/orders/screens/orders_screen.dart';
import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  static const routeName = '/instruction-screen';
  const InstructionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg.png',
                ),
                fit: BoxFit.cover),
          ),
          child: FutureBuilder<List<Tip>>(
              future: TipsDbServices().getTips(diseaseName: SharedPref.load('diseaseName')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CustomProgress());
                }
                if (snapshot.hasData) {
                  final tips = snapshot.data!;
                  return ListView(
                    children: [
                      const AppBarHeader(title: 'ارشادات'),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tips.length,
                        itemBuilder: (context, index) {
                          return TipCard(text: tips[index].containt, borderColor: orange, textStyle: smallOrangeStyle);
                        },
                      )
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
        ),
      ),
    );
  }
}
