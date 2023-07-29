import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/services/files_picker.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/auth/screens/complate_chirty_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class CreateChirityAccountScreen extends StatefulWidget {
  static const routeName = '/create-chirity-account';
  const CreateChirityAccountScreen({super.key});

  @override
  State<CreateChirityAccountScreen> createState() => _CreateChirityAccountScreenState();
}

class _CreateChirityAccountScreenState extends State<CreateChirityAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? imageName;
  File? imageFile;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              // height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('انشاء حساب جديد', style: Theme.of(context).textTheme.headlineLarge),
                  sizedBoxLarge,
                  InkWell(
                    onTap: () async {
                      try {
                        imageFile = await FilesPicker().pickImage();
                        imageName = path.basename(imageFile!.path);
                        setState(() {});
                      } catch (e) {}
                    },
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.transparent,
                        child: (imageFile == null)
                            ? Image.asset("assets/images/pick_image.png", scale: 1.2)
                            : CircleAvatar(radius: 70, backgroundImage: FileImage(imageFile!))),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
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
                    child: Form(
                      key: _formKey,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          children: [
                            TextInput(
                                labelText: 'الاسم الكامل',
                                icon: 'assets/icons/user.svg',
                                controller: _fullNameController,
                                keyboardType: TextInputType.text),
                            sizedBoxMedium,
                            TextInput(
                                labelText: 'العنوان',
                                icon: 'assets/icons/location.svg',
                                controller: _addressController,
                                keyboardType: TextInputType.text),
                            sizedBoxMedium,
                            TextInput(
                                labelText: 'البريد الإلكتروني',
                                icon: 'assets/icons/email.svg',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress),
                            sizedBoxMedium,
                            TextInput(
                                labelText: 'كلمة السر',
                                icon: 'assets/icons/lock.svg',
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword),
                            sizedBoxMedium,
                            TextInput(
                                labelText: 'رقم الهاتف',
                                icon: 'assets/icons/phone.svg',
                                controller: _phoneController,
                                keyboardType: TextInputType.phone)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 20),
                      child: ElevatedGradientButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();

                            var user = Charity(
                              services: '',
                              email: _emailController.text,
                              name: _fullNameController.text,
                              password: _passwordController.text,
                              phoneNumber: _phoneController.text,
                              location: _addressController.text,
                              userType: UserType.charityOrg,
                            );

                            Navigator.of(context).pushNamed(ComplateChirtyInfoScreen.routeName,
                                arguments: {'user': user, 'imageFile': imageFile, 'imageName': imageName});
                          },
                          text: 'التالي')),
                ],
              )),
        ],
      ),
    );
  }
}
