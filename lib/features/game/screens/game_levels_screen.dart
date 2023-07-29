import 'package:disaoled_people/config/constants/constant.dart';
import 'package:disaoled_people/config/theme/theme.dart';
import 'package:disaoled_people/features/game/data/data.dart';
import 'package:disaoled_people/features/game/screens/level_screen.dart';
import 'package:flutter/material.dart';

class GameLevelsScreen extends StatefulWidget {
  static const routeName = '/game-levels-screen';
  const GameLevelsScreen({super.key});

  @override
  State<GameLevelsScreen> createState() => _GameLevelsScreenState();
}

class _GameLevelsScreenState extends State<GameLevelsScreen> {
  @override
  void initState() {
    super.initState();
  }

  int index = 0;
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
                    'الأحرف',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryColor, fontSize: 26),
                  ),
                  sizedBoxLarge,
                  sizedBoxLarge,
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: levels.length,
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        // levels[index].isVisted ? 4 : 1
                        border: Border.all(color: secondaryColor, width: 2),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(LevelScreen.routeName,
                            arguments: levels.indexWhere((element) => element.id == levels[index].id)),
                        child: Image.asset(
                          levels[index].levelImage,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    ),
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
