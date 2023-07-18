import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class BoxStoryMode extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isButton;
  Function fun;
  BoxStoryMode({
    required this.iconData,
    required this.title,
    required this.fun,
    this.isButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isButton
            ? MyColors.greyForButtons
            : MyColors.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: 20,
            // ),
            child: Text(
              title,
              style: generateStyle(
                FontWeight.normal,
                MyColors.white,
                MySize.buttonTitle,
              ),
            ),
          ),
          InkWell(
            onTap: isButton ? () => fun() : () => fun(title),
            child: Container(
              child: Icon(
                iconData,
                color: MyColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
