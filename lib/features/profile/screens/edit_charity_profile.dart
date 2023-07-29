import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/services/files_picker.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

class EditChirityProfileScreen extends StatefulWidget {
  static const routeName = '/edit-chirity-account';
  const EditChirityProfileScreen({super.key});

  @override
  State<EditChirityProfileScreen> createState() => _EditChirityProfileScreenState();
}

class _EditChirityProfileScreenState extends State<EditChirityProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _servicesController = TextEditingController();

  String? imageName;
  File? imageFile;

  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final charity = ModalRoute.of(context)!.settings.arguments as Charity;

      _fullNameController.text = charity.name;
      _addressController.text = charity.location;
      _emailController.text = charity.email;
      _passwordController.text = charity.password;
      _phoneController.text = charity.phoneNumber;
      _servicesController.text = charity.services;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final charity = ModalRoute.of(context)!.settings.arguments as Charity;

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
                  Text('تعديل حساب جديد', style: Theme.of(context).textTheme.headlineLarge),
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
                        child: (imageFile == null)
                            ? charity.image != null
                                ? CircleAvatar(radius: 60, backgroundImage: NetworkImage(charity.image!))
                                : Image.asset("assets/images/pick_image.png", scale: 1.2)
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
                                keyboardType: TextInputType.phone),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'الخدمات التي تقدمها الجمعية',
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      SvgPicture.asset('assets/icons/services.svg')
                                    ],
                                  ),
                                ),
                                TextInput(labelText: '', icon: '', controller: _servicesController, maxLines: 7),
                                sizedBoxLarge,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 20),
                      child: !isLoading
                          ? ElevatedGradientButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                _formKey.currentState!.save();

                                String? imageUrl;
                                setState(() {
                                  isLoading = true;
                                });
                                if (imageFile != null) {
                                  imageUrl = await FileDbService(context).uploadeimage(imageName!, imageFile!);
                                }
                                if (imageUrl == 'error') {
                                  showErrorSnackBar(context, 'حدث خطأ عند تعديل البيانات');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }
                                var user = Charity(
                                  id: charity.id,
                                  services: _servicesController.text,
                                  email: _emailController.text,
                                  name: _fullNameController.text,
                                  image: imageUrl ?? charity.image,
                                  password: _passwordController.text,
                                  phoneNumber: _phoneController.text,
                                  location: _addressController.text,
                                  userType: UserType.charityOrg,
                                );
                                await UserDbServices().updateUser(user, context);
                              },
                              text: 'حفظ')
                          : const Center(
                              child: CustomProgress(),
                            )),
                ],
              )),
        ],
      ),
    );
  }
}
