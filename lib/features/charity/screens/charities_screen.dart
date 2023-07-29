import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/charity/services/charities_db_services.dart';
import 'package:disaoled_people/features/charity/widgets/charity_card_widget.dart';
import 'package:disaoled_people/features/orders/screens/orders_screen.dart';
import 'package:disaoled_people/features/profile/screens/charity_profile_screen.dart';
import 'package:flutter/material.dart';

class CharitiesScreen extends StatefulWidget {
  static const routeName = '/charity_screen';

  const CharitiesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CharitiesScreen> createState() => _CharitiesScreenState();
}

class _CharitiesScreenState extends State<CharitiesScreen> {
  List<Charity> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg.png',
                ),
                fit: BoxFit.cover),
          ),
          child: FutureBuilder<List<Charity>>(
              future: CharitiesDbServices().getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CustomProgress());
                }

                if (snapshot.hasData) {
                  items = snapshot.data!;

                  return ListView(
                    children: [
                      const AppBarHeader(title: 'الجمعيات'),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return CardWidget(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(CharityProfileScreen.routeName, arguments: items[index].id);
                            },
                            item: items[index],
                            colorIndex: (index / 2) % 2 > 0 ? 1 : 0,
                          );
                        },
                      )
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Text('nothing');
              })),
    ));
  }
}
