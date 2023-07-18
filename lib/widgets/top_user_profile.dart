import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proj3/data/colors.dart';

import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class TopUserProfile extends StatelessWidget {
  final double score;
  final int imageIndex;
  final String name;
  final Color borderColor;
  const TopUserProfile({
    super.key,
    required this.name,
    required this.imageIndex,
    required this.score,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 4,
              color: borderColor,
            ),
          ),
          child: CircleAvatar(
            radius: borderColor == MyColors.gold ? 60 : 45,
            // backgroundImage: AssetImage(
            //   'assets/images/Group${imageIndex}.png',
            // ),
            child: SvgPicture.asset('assets/images/Group${imageIndex}.svg'),
          ),
        ),
        Text(
          name,
          style: generateStyle(
            FontWeight.w500,
            MyColors.white,
            MySize.leaderboardTop,
          ),
        ),
        Text(
          '${score}',
          style: generateStyle(
            FontWeight.normal,
            MyColors.white,
            MySize.leaderboardTop,
          ),
        ),
      ],
    );
  }
}
