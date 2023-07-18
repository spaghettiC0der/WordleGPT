import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class CategoryItemStoryMode extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function fun;
  final bool isExist;
  const CategoryItemStoryMode({
    super.key,
    required this.iconData,
    required this.title,
    required this.fun,
    required this.isExist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Player.tabPlay();
        if (!isExist) {
          fun(title);
          Navigator.pop(context);
        }
      },
      child: Container(
        width: 120,
        height: 50,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isExist
              ? MyColors.greyFailedForKeyboard
              : MyColors.greyForButtons,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: generateStyle(
                FontWeight.w500,
                MyColors.white,
                MySize.buttonTitle,
              ),
            ),
            Icon(
              iconData,
              color: MyColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
