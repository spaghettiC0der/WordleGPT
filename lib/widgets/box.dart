import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class Box extends StatelessWidget {
  final int state;
  final String txt;
  Box({this.state = 1, this.txt = ' '});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.all(4),
      child: Text(
        txt,
        style: generateStyle(
          FontWeight.normal,
          MyColors.white,
          MySize.boxLetter,
        ),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        /*
            state:
            1 - not active box
            2 - active not correct
            3 - active correct
            4 - active semi correct
         */
        color: state == 1
            ? MyColors.blanckBox
            : state == 2
                ? MyColors.greyFailed
                : state == 3
                    ? MyColors.green
                    : MyColors.yellow,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
