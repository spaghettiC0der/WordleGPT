import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'dart:math' as math;
import 'package:proj3/models/first_page_argument.dart';
import 'package:proj3/widgets/page_temp.dart';

import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class Difficulty extends StatefulWidget {
  const Difficulty({super.key});

  @override
  State<Difficulty> createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
  final List<String> diff = ['Easy', 'Medium', 'Hard', 'Random'];
  String selectedDiff = 'Easy';

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Choose difficulty',
      list: [
        Container(
          height: MediaQuery.of(context).size.height - 115,
          padding: EdgeInsets.only(
            left: 40,
            right: 40,
            bottom: 30,
            top: 60,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Wrap(
                    children: diff
                        .map(
                          (e) => InkWell(
                            child: Container(
                              // width: 300,
                              height: 70,
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(
                                // horizontal: 12,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: selectedDiff == e
                                    ? MyColors.green
                                    : MyColors.greyForButtons,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2.5,
                                  color: selectedDiff == e
                                      ? MyColors.green
                                      : MyColors.white,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  e,
                                  style: generateStyle(
                                    FontWeight.w500,
                                    MyColors.white,
                                    MySize.buttonTitle,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Player.tabPlay();
                              setState(() {
                                selectedDiff = e;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 120,
                  height: 50,
                  margin: const EdgeInsets.only(
                    // right: 50,
                    // bottom: 30,
                    top: 10,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Player.tabPlay();
                      Navigator.pushNamed(
                        context,
                        '/categories-page',
                        arguments: FirstPageArgument(
                          diff: selectedDiff == 'Random'
                              ? diff[math.Random().nextInt(3)]
                              : selectedDiff,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Next',
                          style: generateStyle(
                            FontWeight.w500,
                            MyColors.white,
                            MySize.buttonTitle,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
