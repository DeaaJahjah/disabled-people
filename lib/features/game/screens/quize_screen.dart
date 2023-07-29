import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/config/widgets/custom_snackbar.dart';
import 'package:disaoled_people/features/game/data/data.dart';
import 'package:disaoled_people/features/game/screens/score_screen.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz-screen';
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int correctAnswerCount = 0;
  String selectedOption = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/game_bg.png',
                  ),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          'assets/images/back.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    )
                  ]),
                  sizedBoxLarge,
                  sizedBoxLarge,
                  Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: secondaryColor, width: 2),
                      image: DecorationImage(
                          image: AssetImage(
                            questions[index].levelImage,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  sizedBoxMedium,
                  Text(
                    'اختر الكلمة التي تتضمن هذا الحرف',
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor, fontSize: 18),
                  ),
                  sizedBoxMedium,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: questions[index]
                          .options
                          .map((option) => ControllButton(
                                title: option,
                                isSelected: selectedOption == option,
                                onTap: () {
                                  selectedOption = option;
                                  setState(() {});
                                },
                              ))
                          .toList()),
                  sizedBoxMedium,
                  sizedBoxMedium,
                  InkWell(
                    onTap: () async {
                      if (selectedOption == '') {
                        showErrorSnackBar(context, 'الرجاء اختيار اجابة');
                        return;
                      }
                      if (questions[index].correcrAnswer == selectedOption) {
                        correctAnswerCount++;
                      }

                      selectedOption = '';
                      if (index != questions.length) {
                        index++;
                      }
                      setState(() {});
                      print(index);

                      if (index == 5) {
                        await Navigator.of(context)
                            .pushNamed(ScoreScreen.routeName, arguments: correctAnswerCount)
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              correctAnswerCount = 0;
                              selectedOption = '';
                              index = 0;
                            });
                          } else {
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    child: Container(
                        height: 45,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: secondaryColor, width: 2),
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Text(
                          'موافق',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    // player.dispose();
    super.dispose();
  }
}

class ControllButton extends StatelessWidget {
  const ControllButton({super.key, required this.onTap, required this.title, required this.isSelected});
  final void Function()? onTap;
  final String title;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 45,
          width: 80,
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !isSelected ? secondaryColor : orange,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
