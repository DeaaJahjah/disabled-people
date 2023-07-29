import 'dart:io';

import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/services/file_db_service.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/models/charity.dart';
import 'package:disaoled_people/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ComplateChirtyInfoScreen extends StatefulWidget {
  static const routeName = '/complate-chirty-info';
  //static const routeName = '/';

  const ComplateChirtyInfoScreen({super.key});

  @override
  State<ComplateChirtyInfoScreen> createState() => _ComplateChirtyInfoScreenState();
}

class _ComplateChirtyInfoScreenState extends State<ComplateChirtyInfoScreen> {
  final _servicesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? imageName = data['imageName'];
    File? imageFile = data['imageFile'];
    Charity charity = data['user'];
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
              Text('اكمال عملية انشاء الحساب', style: Theme.of(context).textTheme.headlineLarge),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: isLoading
                      ? const Center(child: CustomProgress())
                      : ElevatedGradientButton(
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
                              imageUrl = await FileDbService(context).uploadeimage(imageName!, imageFile);
                            }
                            if (imageUrl == 'error') {
                              showErrorSnackBar(context, 'حدث خطأ عند انشاء الحساب');
                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            charity = charity.copyWith(image: imageUrl, services: _servicesController.text);
                            await FlutterFireAuthServices().signUp(userModle: charity, context: context);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          text: 'انشاء حساب')),
            ],
          )),
    );
  }
}
