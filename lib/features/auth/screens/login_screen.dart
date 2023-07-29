import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_progress.dart';
import 'package:disaoled_people/config/widgets/elevated_gradient_button.dart';
import 'package:disaoled_people/config/widgets/text_input.dart';
import 'package:disaoled_people/features/auth/screens/selecte_account_type_screen.dart';
import 'package:disaoled_people/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('تسجيل الدخول', style: Theme.of(context).textTheme.headlineLarge),
                sizedBoxLarge,
                Image.asset("assets/images/logo.png", scale: 1.2),
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
                  child: Form(
                    key: _formKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          TextInput(
                              labelText: 'البريد الإلكتروني',
                              icon: 'assets/icons/email.svg',
                              controller: _emailController),
                          sizedBoxMedium,
                          TextInput(
                              labelText: 'كلمة السر', icon: 'assets/icons/lock.svg', controller: _passwordController),
                        ],
                      ),
                    ),
                  ),
                ),
                sizedBoxLarge,
                !isLoading
                    ? ElevatedGradientButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();
                          setState(() {
                            isLoading = true;
                          });
                          await FlutterFireAuthServices().signIn(
                              email: _emailController.text, password: _passwordController.text, context: context);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        text: 'تسجيل دخول')
                    : const CustomProgress(),
                sizedBoxLarge,
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SelectAccountTypeScreen.routeName);
                  },
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'في حال لا تملك حساب, ',
                        style: TextStyle(color: orange, fontFamily: font, fontSize: 18, fontWeight: FontWeight.w900)),
                    TextSpan(
                      text: ' انشئ حساب جديد',
                      style:
                          TextStyle(color: secondaryColor, fontFamily: font, fontSize: 18, fontWeight: FontWeight.w900),
                    )
                  ])),
                )
              ],
            )),
      ),
    );
  }
}
