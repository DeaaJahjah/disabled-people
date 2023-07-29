import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/utils/shared_pref.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/auth/providers/user_provider.dart';
import 'package:disaoled_people/features/auth/services/auth_services.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:disaoled_people/features/charity/screens/charities_screen.dart';
import 'package:disaoled_people/features/chat/messages_screen.dart';
import 'package:disaoled_people/features/game/screens/game_levels_screen.dart';
import 'package:disaoled_people/features/healthTips/screens/health_tips_screen.dart';
import 'package:disaoled_people/features/home/category_card.dart';
import 'package:disaoled_people/features/orders/screens/add_order_screen.dart';
import 'package:disaoled_people/features/orders/screens/my_orders_screen.dart';
import 'package:disaoled_people/features/orders/screens/orders_screen.dart';
import 'package:disaoled_people/features/profile/screens/charity_profile_screen.dart';
import 'package:disaoled_people/features/profile/screens/patient_profile_screen.dart';
import 'package:disaoled_people/features/profile/screens/person_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        context.read<UserProvider>().getUserData();
        await UserDbServices().getUser(uid);
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // UserDbServices().creatUser(
    //     context: context,
    //     user: Charity(
    //         email: 'dadd@gmai.com',
    //         name: 'test',
    //         password: 'dadadad',
    //         phoneNumber: '98765432',
    //         location: 'location',
    //         services: 'services',
    //         image:
    //             'https://firebasestorage.googleapis.com/v0/b/disabled-people.appspot.com/o/FB_IMG_1678870865169.jpg?alt=media&token=fd9dd9bb-75a8-4630-99ab-e2813e8b1835',
    //         userType: UserType.charityOrg));
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg.png',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Builder(builder: (context) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: SvgPicture.asset(
                          'assets/icons/menu.svg',
                          width: 30,
                          height: 30,
                        ),
                      );
                    }),
                    Text('الرئيسية', style: Theme.of(context).appBarTheme.titleTextStyle),
                    StreamBuilder<int>(
                        stream: StreamChatCore.of(context).client.state.totalUnreadCountStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return InkWell(
                              onTap: () => Navigator.of(context).pushNamed(MessagesScreen.routeName),
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/chat.svg',
                                    height: 30,
                                    width: 30,
                                  ),
                                  if (snapshot.data != 0)
                                    CircleAvatar(
                                      backgroundColor: primaryColor,
                                      radius: 10,
                                      child: Text(
                                        snapshot.data.toString(),
                                        style: const TextStyle(color: white, fontSize: 8),
                                      ),
                                    )
                                ],
                              ),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(color: primaryColor),
                            );
                          }
                          return const SizedBox.shrink();
                        }),
                  ]),
                ),
                sizedBoxLarge,
                Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 100,
                ),
                sizedBoxMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CategoryCard(
                      colors: [secondaryColor, orange],
                      image: 'assets/images/charities.png',
                      title: 'جمعيات',
                      routName: CharitiesScreen.routeName,
                    ),
                    CategoryCard(
                      colors: [secondaryColor, secondaryColor],
                      image: 'assets/images/orders.png',
                      title: 'طلبات',
                      routName: OrdersScreen.routeName,
                    ),
                  ],
                ),
                if (SharedPref.load('type') == UserType.patient.name)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CategoryCard(
                        colors: [primaryColor, secondaryColor],
                        image: 'assets/images/games.png',
                        title: 'ألعاب',
                        routName: GameLevelsScreen.routeName,
                      ),
                      CategoryCard(
                        colors: [primaryColor, primaryColor],
                        image: 'assets/images/healthTips.png',
                        title: 'إرشادات صحية',
                        routName: InstructionScreen.routeName,
                      ),
                    ],
                  )
              ],
            ),
          ),
          drawer: Drawer(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Consumer<UserProvider>(builder: (context, value, child) {
                if (value.dataState == DataState.notSet) {
                  final user = value.user;
                  return InkWell(
                    onTap: () {
                      if (SharedPref.load('type') == 'charityOrg') {
                        Navigator.of(context).pushNamed(CharityProfileScreen.routeName);
                      } else if (SharedPref.load('type') == 'benfactor') {
                        Navigator.of(context).pushNamed(PersonProfileScreen.routeName);
                      } else {
                        Navigator.of(context).pushNamed(PatientProfileScreen.routeName);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: orange,
                          child: user!.image != null
                              ? CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(user.image!),
                                )
                              : const SizedBox.shrink(),
                        ),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: primaryColor),
                        ),
                        Text(
                          'حساب ${getAccountTypeName()}',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),
                        ),
                        sizedBoxLarge,
                        DrawerButton(
                          name: 'طلباتي',
                          onTap: () => Navigator.of(context).pushNamed(MyOrdersScreen.routeName),
                        ),
                        DrawerButton(
                          name: 'اضافة طلب',
                          onTap: () => Navigator.of(context).pushNamed(AddOrderScreen.routeName),
                        ),
                        DrawerButton(
                          name: 'تسجيل خروج',
                          onTap: () => FlutterFireAuthServices().signOut(context),
                        )
                      ],
                    ),
                  );
                }

                if (value.dataState == DataState.loading) {
                  return const Center(
                    child: CustomProgress(),
                  );
                }

                return const SizedBox.shrink();
              })
            ]),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.name,
    this.onTap,
  });
  final String name;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: secondaryColor.withOpacity(0.2)),
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor),
        ),
      ),
    );
  }
}

String getAccountTypeName() {
  final type = SharedPref.load('type');
  print('fromd draewer : $type');
  switch (type) {
    case 'benefactor':
      return 'متبرع';

    case 'charityOrg':
      return 'جمعية';

    case 'patient':
      return 'مريض';
  }
  return '';
}
