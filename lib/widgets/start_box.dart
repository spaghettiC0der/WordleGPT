import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/player.dart';

class BoxStart extends StatelessWidget {
  final IconData icon;
  final double size;
  final String moveTo;
  BoxStart(
      {super.key,
      required this.icon,
      required this.size,
      required this.moveTo});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Player.tabPlay();
        Navigator.pushNamed(context, moveTo);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/vec.png',
            ),
          ),
        ),
        child: Icon(
          icon,
          size: icon == Icons.play_arrow_rounded ? size / 1.4 : size / 2.3,
          color: MyColors.white,
        ),
      ),
    );
  }
}
