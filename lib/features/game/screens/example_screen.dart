import 'package:audioplayers/audioplayers.dart';
import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/game/data/data.dart';
import 'package:disaoled_people/features/game/models/level.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatefulWidget {
  static const routeName = '/example-screen';
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  void loadAudio() async {
    await player.setSourceAsset(levels[0].levelSound);
  }

  bool isplaying = false;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final level = ModalRoute.of(context)!.settings.arguments as Level;
    return SafeArea(
      child: Scaffold(
        body: Center(
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
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  // border: Border.all(color: secondaryColor, width: 2),
                  image: DecorationImage(
                      image: AssetImage(
                        level.levelExampleImage,
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              sizedBoxMedium,
              ControllButton(
                  onTap: () {
                    setState(() {
                      isplaying = true;
                    });

                    player.play(AssetSource(level.levelExampleSound)).whenComplete(() => setState(() {
                          isplaying = false;
                        }));
                  },
                  asset: !isplaying ? 'sound_on' : 'sound_off'),
            ],
          ),
        ),
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
