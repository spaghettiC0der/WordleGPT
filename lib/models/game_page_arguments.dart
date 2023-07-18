class GamePageArgument {
  final String finalWord;
  final List hints;
  bool hasNext;
  final bool isStoryMode;
  final String category;
  final String diff;
  GamePageArgument({
    required this.finalWord,
    required this.hints,
    this.hasNext = false,
    this.isStoryMode = false,
    required this.category,
    required this.diff,
  });
}
