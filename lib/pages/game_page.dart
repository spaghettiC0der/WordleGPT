import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/keys_data.dart';
import 'package:proj3/functions/finish_game.dart';
import 'package:proj3/functions/open_hint.dart';
import 'package:proj3/functions/word_exist_check.dart';
import 'package:proj3/models/key_model.dart';
import 'package:proj3/models/pointer.dart';
import 'package:proj3/models/row_data.dart';
import 'package:proj3/widgets/keyboard.dart';
import 'package:proj3/widgets/page_temp.dart';
import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';
import '../models/game_page_arguments.dart';
import '../widgets/box_row.dart';

class Game extends StatefulWidget {
  final GamePageArgument arg;
  const Game({super.key, required this.arg});
  @override
  State<Game> createState() => _GameState(arg: arg);
}

class _GameState extends State<Game> {
  _GameState({required this.arg});

  static int lengthOfWord = 10;
  int hintIndex = 0;
  int attempts = 0;
  String answer = '';
  List<Widget> hints = [];
  final GamePageArgument arg;
  List<RowData> rowDataList = [];
  List<int> temp = [];
  bool isChecking = false;
  @override
  void initState() {
    lengthOfWord = arg.finalWord.length;
    hintIndex = 0;
    answer = arg.finalWord;
    temp = [hintIndex];
    attempts = 1;
    hints = List.generate(
      3,
      (index) => Container(
        padding: EdgeInsets.all(
          5,
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(
                Icons.circle,
                size: 8,
                color: MyColors.white,
              ),
            ),
            Flexible(
              child: Text(
                arg.hints[index],
                style: generateStyle(
                  FontWeight.normal,
                  MyColors.white,
                  MySize.alertText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    rowDataList = List.generate(
      6,
      (index) => RowData(
        text: ' ' * (lengthOfWord),
        states: List.generate(lengthOfWord, (index) => 1),
      ),
    );
    for (int j = 0; j < 3; j++) {
      for (var x in keyDataList[j]) {
        x.state = 1;
      }
    }
    super.initState();
    setState(() {});
  }

  void refreshLetter(KeyData data) async {
    if (data.type == 1) {
      if (pointer.column < lengthOfWord) {
        rowDataList[pointer.row].text = rowDataList[pointer.row]
            .text
            .replaceRange(pointer.column, pointer.column + 1, data.letter);
        pointer.column++;
        if (pointer.column == lengthOfWord) {
          keyDataList[2][0].state = 5;
        }
      }
    } else if (data.type == 2) {
      if (pointer.column == lengthOfWord) {
        setState(() {
          isChecking = true;
        });
        //check if word is correct
        int correctPositions = 0;
        for (int i = 0; i < lengthOfWord; i++) {
          if (answer[i] == rowDataList[pointer.row].text[i]) {
            correctPositions++;
          }
        }
        if (correctPositions == lengthOfWord) {
          await Player.winPlay();
          await finishGame(context, arg, answer, hintIndex, true, attempts);
        } else {
          bool ch = await isExist(rowDataList[pointer.row].text);
          if (!ch) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The word does not exist'),
              ),
            );
            setState(() {
              isChecking = false;
            });
            return;
          }
          await check();
          setState(() {
            isChecking = false;
          });
          attempts++;
          pointer.column = 0;
          pointer.row++;
        }
      }
    } else if (pointer.column > 0) {
      keyDataList[2][0].state = 1;
      pointer.column--;
      rowDataList[pointer.row].text = rowDataList[pointer.row]
          .text
          .replaceRange(pointer.column, pointer.column + 1, ' ');
    }
    setState(() {});
  }

  check() async {
    keyDataList[2][0].state = 1;
    int correctPositions = 0;
    for (int i = 0; i < lengthOfWord; i++) {
      if (answer[i] == rowDataList[pointer.row].text[i]) {
        correctPositions++;
        rowDataList[pointer.row].states[i] = 3;
        for (int j = 0; j < 3; j++) {
          for (var x in keyDataList[j]) {
            if (x.letter == answer[i]) {
              x.state = 3;
            }
          }
        }
      } else if (answer.contains(rowDataList[pointer.row].text[i])) {
        rowDataList[pointer.row].states[i] = 4;
        for (int j = 0; j < 3; j++) {
          for (var x in keyDataList[j]) {
            if (x.letter == rowDataList[pointer.row].text[i]) {
              if (x.state != 3) x.state = 4;
            }
          }
        }
      } else {
        rowDataList[pointer.row].states[i] = 2;
        for (int j = 0; j < 3; j++) {
          for (var x in keyDataList[j]) {
            if (x.letter == rowDataList[pointer.row].text[i]) {
              x.state = 2;
            }
          }
        }
      }
    }
    //successful attemp -> show successful box
    if (correctPositions == lengthOfWord) {
      await Player.winPlay();
      // await ProfileInfo.setData(
      //   score: calculatePoints(ProfileInfo.score, attempts, true, arg.diff,
      //       lengthOfWord, hintIndex),
      //   win: ProfileInfo.win + 1,
      //   recentInRow: ProfileInfo.isStreak == 1
      //       ? ProfileInfo.recentInRow + 1
      //       : ProfileInfo.recentInRow,
      //   maxInRow: math.max(ProfileInfo.maxInRow, ProfileInfo.recentInRow),
      //   winFirstAttempt: attempts == 1 ? 1 : 0,
      //   winWithoutHints: hintIndex == 0
      //       ? ProfileInfo.winWithoutHints + 1
      //       : ProfileInfo.winWithoutHints,
      // );
      // await ProfileInfo.getData(ProfileInfo.id);
      finishGame(context, arg, answer, hintIndex, true, attempts);
    } else if (pointer.row + 1 == 6) {
      Player.losePlay();
      // await Player.winPlay();
      // await ProfileInfo.setData(
      //   score: calculatePoints(ProfileInfo.score, attempts, false, arg.diff,
      //       lengthOfWord, hintIndex),
      //   lose: ProfileInfo.lose + 1,
      // );
      // await ProfileInfo.getData(ProfileInfo.id);
      finishGame(context, arg, answer, hintIndex, false, attempts);
    }
  }

  MyPointer pointer = MyPointer(
    row: 0,
    column: 0,
  );

  showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.backgroundColor.withOpacity(0.9),
          title: Text(
            'Do you want to give up?',
            style: generateStyle(
              FontWeight.w200,
              MyColors.white,
              MySize.alertText,
            ),
          ),
          actions: [
            TextButton(
              // onPressed: () => Navigator.pop(context, false),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: Text(
                'No',
              ),
            ),
            TextButton(
              onPressed: () async {
                Player.losePlay();
                return finishGame(
                  context,
                  arg,
                  answer,
                  hintIndex,
                  false,
                  attempts,
                  false,
                );
              },
              child: Text(
                'Yes',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showMyDialog();
      },
      child: Stack(
        children: [
          PageTemp(
            title: 'WORDLE',
            backButton: false,
            inkWell2: InkWell(
              onTap: () {
                Player.tabPlay();
                showMyDialog();
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MyColors.white,
                ),
              ),
            ),
            inkWell: InkWell(
              onTap: () {
                Player.tabPlay();
                openHintDialog(context, hints, temp, true);
                hintIndex = temp[0];
                setState(() {});
              },
              child: Container(
                // child: Image.asset('assets/images/lamp.png'),
                child: SvgPicture.asset('assets/images/lamp.svg'),
                width: 30,

                // color: Colors.red,
                height: 30,
              ),
            ),
            list: [
              Container(
                height: MediaQuery.of(context).size.height - 115,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 40,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '\" ${arg.category} \"',
                            style: generateStyle(
                              FontWeight.w500,
                              MyColors.white,
                              MySize.boxLetter,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            6,
                            (index) => BoxRow(
                                len: lengthOfWord, rowData: rowDataList[index]),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: MyColors.secondaryBackgroundColor,
                      margin: const EdgeInsets.only(
                        top: 60,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 20,
                      ),
                      child: Keyboard(
                        fun: refreshLetter,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isChecking)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black45,
              child: SpinKitFadingFour(
                color: MyColors.white,
              ),
            )
        ],
      ),
    );
  }
}
