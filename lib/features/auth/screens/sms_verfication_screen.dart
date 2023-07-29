import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/features/auth/screens/verfication_complated_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SmsVerficationScreen extends StatefulWidget {
  static const routeName = '/sms-verfication';

  const SmsVerficationScreen({super.key});

  @override
  State<SmsVerficationScreen> createState() => _SmsVerficationScreenState();
}

class _SmsVerficationScreenState extends State<SmsVerficationScreen> {
  bool isLoading = false;
  String verficationCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                sizedBoxLarge,
                sizedBoxLarge,
                sizedBoxLarge,
                Text('ادخل الكود الخاص بك', style: Theme.of(context).textTheme.headlineLarge),
                sizedBoxLarge,
                Image.asset(
                  "assets/images/shaild.png",
                ),
                sizedBoxLarge,
                Text('نم ارسالة رمز التحقق الخاص بك بواسطة رسالة نصية\nقم بادخاله من فضلك لتأكيد الحساب',
                    style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
                sizedBoxLarge,
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
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      keyboardType: TextInputType.number,
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      autoFocus: true,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(borderRadius),
                        activeColor: whitWithOpacity.withOpacity(0.1),
                        activeFillColor: whitWithOpacity,
                        inactiveFillColor: whitWithOpacity,
                        selectedFillColor: whitWithOpacity,
                        selectedColor: whitWithOpacity.withOpacity(0.1),
                        inactiveColor: whitWithOpacity.withOpacity(0.1),
                      ),
                      onChanged: (String value) {
                        verficationCode = value;
                      },
                      onCompleted: (value) async {
                        if (value == '123456') {
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              setState(() {
                                isLoading = true;
                              });
                              Navigator.of(context).pushNamed(VerficationComplateScreen.routeName);
                            },
                          );
                        } else {
                          showErrorSnackBar(context, 'الرمز المدخل غير صحيح');
                        }
                      },
                    )),
                sizedBoxLarge,
                isLoading ? const Center(child: CustomProgress()) : const SizedBox.shrink()
              ],
            ),
          )),
    );
  }
}
