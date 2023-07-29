import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ScoreScreen extends StatefulWidget {
  static const routeName = '/score-screen';

  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 10));
    _controllerBottomCenter = ConfettiController(duration: const Duration(seconds: 10));
    Future.delayed(Duration.zero, () {
      int score = ModalRoute.of(context)!.settings.arguments as int;
      if (score != 0) {
        _controllerTopCenter.play();
        _controllerBottomCenter.play();
        player.play(AssetSource('laugh.mp3'));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int score = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirectionality: BlastDirectionality.explosive, // don't specify a direction, blast randomly
              shouldLoop: true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: -pi / 2,
              emissionFrequency: 0.01,
              numberOfParticles: 20,
              maxBlastForce: 100,
              minBlastForce: 80,
              gravity: 0.3,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                score != 0 ? 'أحسنت لقد اجبت على $score من 5' : 'لقد حصلت على $score من 5 \n حاول مجدداً',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: secondaryColor),
              ),
              sizedBoxMedium,
              RatingBar.builder(
                initialRating: score.toDouble(),
                unratedColor: orange.withOpacity(0.5),
                direction: Axis.horizontal,
                itemCount: 5,
                maxRating: score.toDouble(),
                minRating: score.toDouble(),
                ignoreGestures: true,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: secondaryColor,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              sizedBoxMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                    },
                    child: Container(
                        height: 45,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Text(
                          'خروج',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Container(
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Text(
                          'محاولة اخرى',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        )),
                  )
                ],
              )
            ]),
          )
        ],
      )),
    );
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();

    super.dispose();
  }
}
