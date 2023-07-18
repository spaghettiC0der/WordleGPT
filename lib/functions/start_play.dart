import 'package:flutter/material.dart';

import '../models/game_page_arguments.dart';
import 'getWord.dart';

startPlaying(BuildContext context, String cat, String freq,
    [bool isStoryMode = false, bool hasNext = false]) async {
  Navigator.pushNamed(context, '/loading-screen');
  bool ok = false;
  String finalWord = '';
  List hints = [];
  while (!ok) {
    var rep;
    try {
      rep = await getWord(cat, freq).timeout(Duration(seconds: 15));
    } catch (e) {
      print('time out trying again');
      continue;
    }
    finalWord = rep['word'].toString().toUpperCase();
    if (finalWord.length > 7 || finalWord.length < 4) continue;
    hints = rep['hints'];
    ok = true;
  }

  Navigator.pop(context);
  await Navigator.pushNamed(
    context,
    '/game',
    arguments: GamePageArgument(
      finalWord: finalWord,
      hints: hints,
      hasNext: hasNext,
      isStoryMode: isStoryMode,
      category: cat,
      diff: freq,
    ),
  ).then((_) {
    return;
  });
}
