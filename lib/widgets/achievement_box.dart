import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class AchievementBox extends StatelessWidget {
  String title;
  int total;
  int winned;
  AchievementBox({
    super.key,
    required this.title,
    this.total = 0,
    this.winned = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: MyColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        top: 30,
        left: 10,
        right: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 7,
                ),
                width: 218,
                child: Text(
                  title,
                  style: generateStyle(
                    FontWeight.normal,
                    MyColors.white,
                    MySize.acheivementText,
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 230,
                    height: 10,
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 230 / total * winned,
                    height: 10,
                    decoration: BoxDecoration(
                      color: MyColors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${winned}/${total}',
            style: generateStyle(
              FontWeight.normal,
              MyColors.white,
              MySize.acheivementText,
            ),
          ),
        ],
      ),
    );
  }
}
