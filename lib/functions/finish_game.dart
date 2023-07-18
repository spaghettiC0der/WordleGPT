import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/models/game_page_arguments.dart';

import '../data/player.dart';
import '../data/profile.dart';
import '../data/text_sizes.dart';
import '../widgets/hint_box.dart';
import 'calculate_score.dart';
import 'generate_font_style.dart';
import 'dart:math' as math;

finishGame(BuildContext context, GamePageArgument arg, String answer,
    int hintIndex, bool doneCorrectly, int attempts,
    [bool finished = true]) async {
  double preScore = ProfileInfo.score;
  if (doneCorrectly) {
    await ProfileInfo.setData(
      score: calculatePoints(ProfileInfo.score, attempts, true, arg.diff,
          answer.length, hintIndex),
      win: ProfileInfo.win + 1,
      recentInRow: ProfileInfo.isStreak == 1
          ? ProfileInfo.recentInRow + 1
          : ProfileInfo.recentInRow,
      maxInRow: math.max(ProfileInfo.maxInRow, ProfileInfo.recentInRow),
      winFirstAttempt: attempts == 1 ? 1 : 0,
      winWithoutHints: hintIndex == 0
          ? ProfileInfo.winWithoutHints + 1
          : ProfileInfo.winWithoutHints,
      playedStoryMode: arg.isStoryMode ? 1 : ProfileInfo.playedStoryMode,
    );
  } else {
    await ProfileInfo.setData(
      score: calculatePoints(ProfileInfo.score, attempts, false, arg.diff,
          answer.length, hintIndex),
      lose: ProfileInfo.lose + 1,
    );
  }
  await ProfileInfo.getData(ProfileInfo.id);

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            content: Center(
              child: Container(
                width: 400,
                child: HintBox(
                  angle1: Container(),
                  btn: Container(),
                  cover: Container(
                    child: CircleAvatar(
                      backgroundColor:
                          doneCorrectly ? MyColors.green : MyColors.red,
                      radius: 50,
                      child: Icon(
                        doneCorrectly ? Icons.check : Icons.close,
                        color: MyColors.white,
                        size: 70,
                      ),
                    ),
                  ),
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 15,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        doneCorrectly ? 'Congratulations!' : 'Failed',
                        style: generateStyle(
                          FontWeight.w500,
                          MyColors.white,
                          MySize.alertTitle,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 5,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        doneCorrectly
                            ? '${attempts} attempt${attempts > 1 ? 's' : ''} to solve the word'
                            : 'The word was',
                        style: generateStyle(
                          FontWeight.normal,
                          MyColors.white,
                          MySize.alertText,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 15,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '\'${answer}\'',
                        style: generateStyle(
                          FontWeight.w500,
                          doneCorrectly ? MyColors.green : MyColors.red,
                          MySize.alertText,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${preScore.toStringAsFixed(1)}',
                            style: generateStyle(
                              FontWeight.normal,
                              MyColors.white,
                              MySize.alertText,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color:
                                doneCorrectly ? MyColors.green : MyColors.red,
                            size: 15,
                          ),
                          Text(
                            '${ProfileInfo.score.toStringAsFixed(1)}',
                            style: generateStyle(
                              FontWeight.normal,
                              MyColors.white,
                              MySize.alertText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (arg.hasNext)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Player.tabPlay();
                                arg.hasNext = false;
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: MyColors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(
                                  left: 30,
                                  top: 20,
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios,
                                        color: MyColors.white,
                                      ),
                                      Text(
                                        'Menu',
                                        style: generateStyle(
                                          FontWeight.w500,
                                          MyColors.white,
                                          MySize.alertButton,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.only(
                                right: 30,
                                top: 20,
                              ),
                              decoration: BoxDecoration(
                                color: MyColors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    //here
                                    Player.tabPlay();
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    if (arg.isStoryMode && finished == false)
                                      Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Next word',
                                    textAlign: TextAlign.center,
                                    style: generateStyle(
                                      FontWeight.w500,
                                      MyColors.white,
                                      MySize.alertButton,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (arg.isStoryMode && !arg.hasNext)
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Story mode is done!',
                          style: generateStyle(
                            FontWeight.w500,
                            MyColors.white,
                            MySize.alertText,
                          ),
                        ),
                      ),
                  ],
                  fin: true,
                ),
              ),
            ),
          );
        },
      );
    },
  ).then((_) => arg.isStoryMode && arg.hasNext
      ? () => {}
      : Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false));
}
