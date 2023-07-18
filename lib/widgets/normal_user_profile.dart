import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proj3/data/colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class NormalUserProfile extends StatelessWidget {
  final String name;
  final int imageIndex;
  final double score;
  final bool isImproved;
  final int idx;
  const NormalUserProfile({
    super.key,
    required this.name,
    required this.imageIndex,
    required this.score,
    required this.isImproved,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 55,
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                right: 5,
                left: 5,
              ),
              child: Text(
                '${idx + 1}.',
                style: generateStyle(
                  FontWeight.normal,
                  MyColors.white,
                  MySize.leaderboardText,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset('assets/images/Group${imageIndex}.svg'),
                // backgroundImage: AssetImage(
                //   'assets/images/Group${imageIndex}.png',
                // ),
              ),
            ),
            Text(
              name,
              style: generateStyle(
                FontWeight.w500,
                MyColors.white,
                MySize.leaderboardText,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '${score}',
              style: generateStyle(
                FontWeight.w500,
                MyColors.white,
                MySize.leaderboardText,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
                right: 10,
                left: 14,
              ),
              // child: Icon(
              //   isImproved ? Icons.arrow_upward : Icons.arrow_downward,
              //   color: isImproved ? MyColors.green : MyColors.red,
              // ),
            )
          ],
        ),
      ],
    );
  }
}
