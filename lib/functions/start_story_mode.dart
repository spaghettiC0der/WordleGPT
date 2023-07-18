import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proj3/functions/start_play.dart';

final List<String> diff = [
  'high',
  'medium',
  'low',
];
startStoryMode(BuildContext context, List<String> selectedCategories,
    int numOfWords) async {
  // Map tasks = Map.fromIterable(
  //   selectedCategories,
  //   key: (element) => element,
  //   value: (_) => numOfWords,
  // );
  // List<String> tasks =
  while (numOfWords > 0) {
    numOfWords--;
    String nextWord = selectedCategories
        .elementAt(Random().nextInt(selectedCategories.length));
    // tasks[nextWord]--;
    // if (tasks[nextWord] == 0) tasks.remove(nextWord);
    await startPlaying(context, nextWord, diff[Random().nextInt(diff.length)],
        true, numOfWords > 0);
  }
}
