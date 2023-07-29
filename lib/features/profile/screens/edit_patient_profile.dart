import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/constants/data.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/services/files_picker.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/models/patient.dart';
import 'package:disaoled_people/features/auth/services/user_db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:path/path.dart' as path;

class EditPatientProfileScreen extends StatefulWidget {
  static const routeName = '/edit-patient-account';
  const EditPatientProfileScreen({super.key});

  @override
  State<EditPatientProfileScreen> createState() => _EditPatientProfileScreenState();
}

class _EditPatientProfileScreenState extends State<EditPatientProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  String diseaseName = disease[0];

  DateTime? birthday;

  String? imageName;
  File? imageFile;
  String? docName;
  File? docFile;
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final patient = ModalRoute.of(context)!.settings.arguments as Patient;
      diseaseName = disease[disease.indexWhere((element) => element == patient.disease!.name)];
      _fullNameController.text = patient.name;
      _addressController.text = patient.location;
      _emailController.text = patient.email;
      _passwordController.text = patient.password;
      _phoneController.text = patient.phoneNumber;
      _ageController.text = ('${patient.birhday.year}-${patient.birhday.month}-${patient.birhday.day}').toString();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final patient = ModalRoute.of(context)!.settings.arguments as Patient;

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
                            ? patient.image != null
                                ? CircleAvatar(radius: 60, backgroundImage: NetworkImage(patient.image!))
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
                            Text('معلوماتك الصحية',
                                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: white)),
                            sizedBoxLarge,
                            InkWell(
                              onTap: () async {
                                try {
                                  docFile = await FilesPicker().pickImage();
                                  docName = path.basename(docFile!.path);
                                  setState(() {});
                                } catch (e) {}
                                print(docFile);
                              },
                              child: CircleAvatar(
                                  radius: 60,
                                  child: patient.disease!.doc != '' && docFile == null
                                      ? CircleAvatar(
                                          radius: 70,
                                          backgroundImage: NetworkImage(patient.disease!.doc),
                                        )
                                      : (docFile == null)
                                          ? Image.asset("assets/images/add_doc.png", scale: 1.2)
                                          : CircleAvatar(
                                              radius: 70,
                                              backgroundColor: Colors.transparent,
                                              backgroundImage: FileImage(docFile!))),
                            ),
                            sizedBoxMedium,
                            Text('اضف وثائق ثبوتية للمرض', style: Theme.of(context).textTheme.displayMedium),
                            sizedBoxLarge,
                            sizedBoxLarge,
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 230,
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
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: SizedBox(
                                  width: 100,
                                  child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        fillColor: Colors.transparent,
                                      ),
                                      dropdownColor: secondaryColor,
                                      elevation: 0,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      items: disease
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                alignment: Alignment.centerRight,
                                                child: SizedBox(width: 150, child: Text(e)),
                                              ))
                                          .toList(),
                                      value: diseaseName,
                                      onChanged: (selectedDisease) {
                                        diseaseName = selectedDisease!;
                                      }),
                                ),
                              ),
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
                                if (diseaseName == 'اسم المرض') {
                                  showErrorSnackBar(context, 'الرجاء اختيار مرض');
                                  return;
                                }

                                setState(() {
                                  isLoading = true;
                                });
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
                                String? docUrl;
                                if (docFile != null) {
                                  docUrl = await FileDbService(context).uploadeimage(docName!, docFile!);
                                }

                                if (docUrl == 'error') {
                                  // ignore: use_build_context_synchronously
                                  showErrorSnackBar(context, 'حدث خطأ عند انشاء الحساب');
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }

                                var user = Patient(
                                    id: patient.id,
                                    birhday: birthday ?? patient.birhday,
                                    email: _emailController.text,
                                    name: _fullNameController.text,
                                    image: imageUrl ?? patient.image,
                                    password: _passwordController.text,
                                    phoneNumber: _phoneController.text,
                                    location: _addressController.text,
                                    userType: patient.userType,
                                    disease: Disease(name: diseaseName, doc: docUrl ?? patient.disease!.doc));
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
