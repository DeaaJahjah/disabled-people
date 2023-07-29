import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/features/auth/models/patient.dart';
import 'package:disaoled_people/features/auth/models/user.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:disaoled_people/features/profile/screens/edit_patient_profile.dart';
import 'package:disaoled_people/features/profile/widgets/edit_button.dart';
import 'package:disaoled_people/features/profile/widgets/profile_info_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class PatientProfileScreen extends StatefulWidget {
  static const routeName = '/patient-profile';
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  String selectedButton = 'معلومات';
  @override
  Widget build(BuildContext context) {
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
            future: UserDbServices().getUser(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CustomProgress());
              }

              if (snapshot.hasData) {
                final patient = snapshot.data! as Patient;
                return Column(
                  children: [
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
                                    backgroundImage: NetworkImage(patient.image!),
                                  )),
                              sizedBoxSmall,
                              Text(
                                patient.name,
                                style: Theme.of(context).textTheme.headlineMedium,
                              )
                            ],
                          )),
                    ]),
                    sizedBoxSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProfileInfoButton(
                          isPressed: selectedButton == 'للتواصل',
                          onPressed: () {
                            selectedButton = 'للتواصل';
                            setState(() {});
                          },
                          text: 'للتواصل',
                        ),
                        ProfileInfoButton(
                          isPressed: selectedButton == 'معلومات',
                          onPressed: () {
                            selectedButton = 'معلومات';
                            setState(() {});
                          },
                          text: 'معلومات',
                        ),
                      ],
                    ),
                    sizedBoxMedium,
                    const Divider(
                      color: secondaryColor,
                      height: 10,
                      thickness: 2,
                      indent: 25,
                      endIndent: 25,
                    ),
                    sizedBoxLarge,
                    // CommunicationSection(email: 'lanaalameer@gmail.com', phoneNum: '34252529425'),
                    if (selectedButton == 'معلومات')
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(patient.location,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/locationIcon.svg', width: 20, height: 20),
                            ],
                          ),
                          sizedBoxLarge,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(Jiffy(patient.birhday).format('yyyy-mm-dd'),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/calenderIcon.svg', width: 20, height: 20),
                            ],
                          ),
                          sizedBoxLarge,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(patient.disease!.name,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              const SizedBox(width: 10),
                              Text('اسم المرض',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              SvgPicture.asset('assets/icons/editIcon.svg', width: 20, height: 20),
                            ],
                          )
                        ]),
                      ),

                    if (selectedButton == 'للتواصل')
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(patient.phoneNumber,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/callPink.svg', width: 20, height: 20),
                            ],
                          ),
                          sizedBoxLarge,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(patient.email,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor)),
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/icons/pinkEmail.svg', width: 20, height: 20),
                            ],
                          )
                        ]),
                      ),
                    sizedBoxLarge,
                    EditButton(onPressed: () async {
                      await Navigator.of(context)
                          .pushNamed(EditPatientProfileScreen.routeName, arguments: patient)
                          .then((value) {
                        if (value != null) {
                          setState(() {});
                        }
                      });
                    })
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
