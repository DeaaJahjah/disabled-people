class Level {
  final int id;
  final String name;
  final String levelImage;
  final String levelSound;
  final String levelExampleImage;
  final String levelExampleSound;
  final bool isVisted;

  Level(
      {required this.id,
      required this.name,
      required this.levelImage,
      required this.levelSound,
      required this.levelExampleImage,
      required this.levelExampleSound,
      required this.isVisted});
}
