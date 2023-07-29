import 'package:audioplayers/audioplayers.dart';
import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/game/data/data.dart';
import 'package:disaoled_people/features/game/screens/example_screen.dart';
import 'package:disaoled_people/features/game/screens/quize_screen.dart';
import 'package:flutter/material.dart';

class LevelScreen extends StatefulWidget {
  static const routeName = '/level-screen';
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  AudioPlayer player = AudioPlayer();
  int index = 0;
  bool isplaying = false;
  @override
  void initState() {
    super.initState();
    loadAudio();
    Future.delayed(Duration.zero, () {
      index = ModalRoute.of(context)!.settings.arguments as int;
      setState(() {});
    });
  }

  void loadAudio() async {
    await player.setSourceAsset(levels[0].levelSound);
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
                  Text(
                    'حرف ${levels[index].name}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor, fontSize: 26),
                  ),
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
                            levels[index].levelImage,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  sizedBoxMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ControllButton(
                          onTap: () {
                            Navigator.of(context).pushNamed(ExampleScreen.routeName, arguments: levels[index]);
                          },
                          asset: 'example'),
                      ControllButton(
                          onTap: () {
                            setState(() {
                              isplaying = true;
                            });

                            player.play(AssetSource(levels[index].levelSound)).whenComplete(() => setState(() {
                                  isplaying = false;
                                }));
                          },
                          asset: !isplaying ? 'sound_on' : 'sound_off'),
                      if (index != levels.length - 1)
                        ControllButton(
                            onTap: () {
                              setState(() {
                                index++;
                              });
                            },
                            asset: 'next'),
                    ],
                  ),
                  sizedBoxMedium,
                  if (index == levels.length - 1)
                    InkWell(
                      onTap: () => Navigator.of(context).pushNamed(QuizScreen.routeName),
                      child: Image.asset(
                        'assets/images/test.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
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
  const ControllButton({
    super.key,
    required this.onTap,
    required this.asset,
  });
  final void Function()? onTap;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 45,
          width: 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Image.asset('assets/images/$asset.png')),
    );
  }
}
