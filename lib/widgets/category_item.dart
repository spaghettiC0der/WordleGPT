import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/functions/start_play.dart';
import 'package:proj3/models/first_page_argument.dart';

import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class CategoryItem extends StatelessWidget {
  final mapDiff = {
    'Easy': 'high',
    'Medium': 'medium',
    'Hard': 'low',
  };
  final String title;
  final IconData iconData;
  final int idx;
  final FirstPageArgument arg;
  CategoryItem({
    required this.title,
    required this.iconData,
    required this.arg,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        // horizontal: 20,
        // vertical: 10,
        // top: 20,
        bottom: 30,
        left: idx % 2 == 1 ? 10 : 0,
        right: idx % 2 == 1 ? 0 : 10,
      ),
      child: InkWell(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: generateStyle(
                        FontWeight.normal,
                        MyColors.white,
                        MySize.buttonTitle,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      iconData,
                      color: MyColors.white,
                    ),
                  ],
                ),
                // width: 150,
                width: MediaQuery.of(context).size.width / 2 - 30,
                height: 60,
                decoration: BoxDecoration(
                    color: MyColors.greyForButtons,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: MyColors.white,
                    )),
              ),
            ],
          ),
          onTap: () async {
            await Player.tabPlay();
            startPlaying(context, title, mapDiff[arg.diff]!);
          }),
    );
  }
}
