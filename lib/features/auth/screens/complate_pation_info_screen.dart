import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/constants/data.dart';
import 'package:disaoled_people/config/enums/enums.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/services/files_picker.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/features/auth/models/patient.dart';
import 'package:disaoled_people/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ComplatePationInfoScreen extends StatefulWidget {
  static const routeName = '/complate-pationt-info';
  const ComplatePationInfoScreen({super.key});

  @override
  State<ComplatePationInfoScreen> createState() => _ComplatePationInfoScreenState();
}

class _ComplatePationInfoScreenState extends State<ComplatePationInfoScreen> {
  String diseaseName = disease[0];
  bool isLoading = false;
  String? docName;
  File? docFile;
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? imageName = data['imageName'];
    File? imageFile = data['imageFile'];
    Patient patient = data['user'];

    return Scaffold(
      body: Container(
          // height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('معلوماتك الصحية', style: Theme.of(context).textTheme.headlineLarge),
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
                    backgroundColor: Colors.transparent,
                    child: (docFile == null)
                        ? Image.asset("assets/images/add_doc.png", scale: 1.2)
                        : CircleAvatar(
                            radius: 70, backgroundColor: Colors.transparent, backgroundImage: FileImage(docFile!))),
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
                                child: Text(e),
                              ))
                          .toList(),
                      value: diseaseName,
                      onChanged: (selectedDisease) {
                        diseaseName = selectedDisease!;
                      }),
                ),
              ),
              sizedBoxLarge,
              Row(children: [
                Text(
                  'اتعهد ان الوثائق صحيحة وعلى مسؤوليتي الشخصية',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Checkbox(
                    value: value,
                    activeColor: primaryColor,
                    onChanged: (onChanged) {
                      setState(() {
                        value = onChanged;
                      });
                    })
              ]),
              sizedBoxLarge,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: isLoading
                      ? const Center(child: CustomProgress())
                      : ElevatedGradientButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (diseaseName == 'اسم المرض') {
                              showErrorSnackBar(context, 'الرجاء اختيار مرض');
                              return;
                            }

                            if (!value!) {
                              showErrorSnackBar(context, 'يجب الموافقة على التعهد');

                              return;
                            }
                            if (docFile == null) {
                              showErrorSnackBar(context, 'الرجاء تحديد وثيقة المرض');
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });

                            String? imageUrl;

                            if (imageFile != null) {
                              imageUrl = await FileDbService(context).uploadeimage(imageName!, imageFile);
                            }
                            if (imageUrl == 'error') {
                              // ignore: use_build_context_synchronously
                              showErrorSnackBar(context, 'حدث خطأ عند انشاء الحساب');
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            String docUrl = await FileDbService(context).uploadeimage(docName!, docFile!);

                            if (docUrl == 'error') {
                              // ignore: use_build_context_synchronously
                              showErrorSnackBar(context, 'حدث خطأ عند انشاء الحساب');
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            patient = patient.copyWith(
                                image: imageUrl,
                                userType: UserType.patient,
                                disease: Disease(name: diseaseName, doc: docUrl));

                            await FlutterFireAuthServices().signUp(userModle: patient, context: context);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          text: 'إنشاء حساب')),
            ],
          )),
    );
  }
}
