import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/profile.dart';
import 'package:proj3/widgets/achievement_box.dart';
import 'package:proj3/widgets/page_temp.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';
import 'dart:math' as math;

class Achievements extends StatelessWidget {
  const Achievements({super.key});
  double calcProgress() {
    return (math.min(5, ProfileInfo.maxInRow) +
            math.min(10, ProfileInfo.maxInRow) +
            math.min(20, ProfileInfo.maxInRow) +
            math.min(30, ProfileInfo.maxInRow) +
            math.min(50, ProfileInfo.maxInRow) +
            math.min(10, ProfileInfo.win) +
            math.min(30, ProfileInfo.win) +
            math.min(50, ProfileInfo.win) +
            math.min(100, ProfileInfo.win) +
            ProfileInfo.playedStoryMode +
            (ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 1001 ? 1 : 0) +
            (ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 101 ? 1 : 0) +
            (ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 11 ? 1 : 0) +
            (ProfileInfo.winWithoutHints >= 10 ? 1 : 0) +
            (ProfileInfo.winWithoutHints >= 30 ? 1 : 0) +
            (ProfileInfo.winWithoutHints >= 50 ? 1 : 0) +
            (ProfileInfo.winWithoutHints >= 100 ? 1 : 0) +
            (ProfileInfo.winFirstAttempt)) /
        410.0 *
        100;
  }

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Achievements',
      list: [
        Container(
          margin: EdgeInsets.only(
            bottom: 30,
          ),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${calcProgress().toStringAsFixed(2)}%',
                    style: generateStyle(
                      FontWeight.w500,
                      MyColors.white,
                      MySize.bigNum,
                    ),
                  ),
                  Text(
                    'progress',
                    style: generateStyle(
                      FontWeight.w500,
                      MyColors.white,
                      MySize.screenText,
                    ),
                  ),
                ],
              ),
              AchievementBox(
                title: 'Win 5 games in a row',
                total: 5,
                winned: math.min(5, ProfileInfo.maxInRow),
              ),
              AchievementBox(
                title: 'Win 10 games in a row',
                total: 10,
                winned: math.min(10, ProfileInfo.maxInRow),
              ),
              AchievementBox(
                title: 'Win 20 games in a row',
                total: 20,
                winned: math.min(20, ProfileInfo.maxInRow),
              ),
              AchievementBox(
                title: 'Win 30 games in a row',
                total: 30,
                winned: math.min(30, ProfileInfo.maxInRow),
              ),
              AchievementBox(
                title: 'Win 50 games in a row',
                total: 50,
                winned: math.min(50, ProfileInfo.maxInRow),
              ),
              AchievementBox(
                title: 'Win 10 games',
                total: 10,
                winned: math.min(10, ProfileInfo.win),
              ),
              AchievementBox(
                title: 'Win 30 games',
                total: 30,
                winned: math.min(30, ProfileInfo.win),
              ),
              AchievementBox(
                title: 'Win 50 games',
                total: 50,
                winned: math.min(50, ProfileInfo.win),
              ),
              AchievementBox(
                title: 'Win 100 games',
                total: 100,
                winned: math.min(100, ProfileInfo.win),
              ),
              AchievementBox(
                title: 'Complete story mode',
                total: 1,
                winned: ProfileInfo.playedStoryMode,
              ),
              AchievementBox(
                title: 'Enter the top 1000 players in the game',
                total: 1,
                winned: ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 1001
                    ? 1
                    : 0,
              ),
              AchievementBox(
                title: 'Enter the top 100 players in the game',
                total: 1,
                winned: ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 101
                    ? 1
                    : 0,
              ),
              AchievementBox(
                title: 'Enter the top 10 players in the game',
                total: 1,
                winned: ProfileInfo.bestRank != 0 && ProfileInfo.bestRank < 11
                    ? 1
                    : 0,
              ),
              AchievementBox(
                title: 'Win 10 games without using hints',
                total: 10,
                winned: ProfileInfo.winWithoutHints >= 10 ? 1 : 0,
              ),
              AchievementBox(
                title: 'Win 30 games without using hints',
                total: 30,
                winned: ProfileInfo.winWithoutHints >= 30 ? 1 : 0,
              ),
              AchievementBox(
                title: 'Win 50 games without using hints',
                total: 50,
                winned: ProfileInfo.winWithoutHints >= 50 ? 1 : 0,
              ),
              AchievementBox(
                title: 'Win 100 games without using hints',
                total: 100,
                winned: ProfileInfo.winWithoutHints >= 100 ? 1 : 0,
              ),
              AchievementBox(
                title: 'Win a game from the first attempt',
                total: 1,
                winned: ProfileInfo.winFirstAttempt,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
