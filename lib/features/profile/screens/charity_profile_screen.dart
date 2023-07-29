import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/extensions/firebase.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:disaoled_people/features/profile/screens/edit_charity_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharityProfileScreen extends StatefulWidget {
  static const routeName = '/charity-profile';
  const CharityProfileScreen({Key? key}) : super(key: key);

  @override
  State<CharityProfileScreen> createState() => _CharityProfileScreenState();
}

class _CharityProfileScreenState extends State<CharityProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)!.settings.arguments as String?;
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/bg.png',
            ),
            fit: BoxFit.cover),
      ),
      child: FutureBuilder<UserModle?>(

          // ignore: prefer_if_null_operators
          future: UserDbServices().getUser(id == null ? uid : id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CustomProgress());
            }

            if (snapshot.hasData) {
              final Charity charity = snapshot.data! as Charity;
              return Column(children: [
                Stack(children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 320,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [primaryColor, secondaryColor])),
                  ),
                  Positioned(
                      top: 150,
                      left: 100,
                      child: Column(
                        children: [
                          CircleAvatar(
                              backgroundColor: orange,
                              radius: 70,
                              child: CircleAvatar(
                                radius: 68,
                                backgroundImage: NetworkImage(charity.image!),
                              )),
                          sizedBoxSmall,
                          Text(
                            charity.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                      )),
                ]),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(charity.location, style: largeOrangeStyle),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/yellowIcon.svg', width: 20, height: 20),
                            ],
                          ),
                          sizedBoxSmall,
                          Text(
                            charity.phoneNumber,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          sizedBoxSmall,
                          Text(
                            charity.email,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
                        width: 2,
                        color: orange,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('للتواصل', style: largeOrangeStyle),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/yellowCall.svg', width: 20, height: 20),
                            ],
                          ),
                          sizedBoxSmall,
                          Text(
                            charity.phoneNumber,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          sizedBoxSmall,
                          Text(
                            charity.email,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('خدماتنا', style: largeOrangeStyle),
                          const SizedBox(width: 10),
                          SvgPicture.asset('assets/icons/service icon.svg', width: 20, height: 20),
                        ],
                      ),
                      sizedBoxSmall,
                      Text(
                        charity.services,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                sizedBoxMedium,
                if (charity.id == context.userUid)
                  ElevatedGradientButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EditChirityProfileScreen.routeName, arguments: charity)
                            .then((value) {
                          if (value != null) {
                            setState(() {});
                          }
                        });
                      },
                      text: 'تعديل المعلومات')
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     width: 200,
                //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: white,
                //         border: Border.all(color: orange, width: 1)),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text('معرفة المزيد', style: Theme.of(context).textTheme.headlineMedium),
                //         const SizedBox(
                //           width: 10,
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ]);
            }
            return const SizedBox.shrink();
          }),
    ));
  }
}
