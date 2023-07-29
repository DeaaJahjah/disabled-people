import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/services/files_picker.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/models/benefactor.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:path/path.dart' as path;

class EditBenefactorProfileScreen extends StatefulWidget {
  static const routeName = '/edit-benefactor-account';
  const EditBenefactorProfileScreen({super.key});

  @override
  State<EditBenefactorProfileScreen> createState() => _EditBenefactorProfileScreenState();
}

class _EditBenefactorProfileScreenState extends State<EditBenefactorProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  DateTime? birthday;

  String? imageName;
  File? imageFile;

  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final benefactor = ModalRoute.of(context)!.settings.arguments as Benefactor;

      _fullNameController.text = benefactor.name;
      _addressController.text = benefactor.location;
      _emailController.text = benefactor.email;
      _passwordController.text = benefactor.password;
      _phoneController.text = benefactor.phoneNumber;
      _ageController.text =
          ('${benefactor.birhday.year}-${benefactor.birhday.month}-${benefactor.birhday.day}').toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final benefactor = ModalRoute.of(context)!.settings.arguments as Benefactor;

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
                  Text('تعديل الحساب ', style: Theme.of(context).textTheme.headlineLarge),
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
                            ? benefactor.image != null
                                ? CircleAvatar(radius: 60, backgroundImage: NetworkImage(benefactor.image!))
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
                            sizedBoxMedium,
                            TextInput(
                              labelText: 'تاريخ الميلاد',
                              icon: 'assets/icons/calendar.svg',
                              controller: _ageController,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              onTap: () async {
                                birthday = await showRoundedDatePicker(
                                  context: context,
                                  lastDate: DateTime.now(),
                                  initialDate: DateTime(1960),
                                  // firstDate: DateTime(2000),
                                  theme: ThemeData(primarySwatch: Colors.pink),
                                );
                                _ageController.text =
                                    ('${birthday!.year}-${birthday!.month}-${birthday!.day}').toString();
                              },
                            ),
                            sizedBoxMedium,
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
                                var user = Benefactor(
                                  id: benefactor.id,
                                  birhday: birthday ?? benefactor.birhday,
                                  email: _emailController.text,
                                  name: _fullNameController.text,
                                  image: imageUrl ?? benefactor.image,
                                  password: _passwordController.text,
                                  phoneNumber: _phoneController.text,
                                  location: _addressController.text,
                                  userType: benefactor.userType,
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
