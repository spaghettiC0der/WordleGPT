import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:flutter_svg/svg.dart';
import '../data/player.dart';
import '../data/text_sizes.dart';
import '../pages/start_page.dart';
import '../widgets/hint_box.dart';
import 'generate_font_style.dart';

Future openHintDialog(
    BuildContext context, List<Widget> hints, List<int> hintIndex,
    [bool isHint = false]) {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState2) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            content: Center(
              child: Container(
                width: 400,
                child: HintBox(
                  isHint: isHint,
                  angle1: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(
                      top: 15,
                      left: 15,
                    ),
                    child: Text(
                      'Hints',
                      style: generateStyle(
                        FontWeight.w500,
                        MyColors.white,
                        MySize.alertTitle,
                      ),
                    ),
                  ),
                  btn: hintIndex[0] == 3
                      ? Container()
                      : Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(
                            bottom: 15,
                            left: 15,
                            top: 15,
                          ),
                          child: InkWell(
                            onTap: () async {
                              Player.tabPlay();
                              if (hintIndex[0] == 2) {
                                await MainPage.ad.getRewardedAd().show(
                                  onUserEarnedReward: (ad, reward) {
                                    if (hintIndex[0] < 3) hintIndex[0]++;
                                    print(hintIndex[0]);
                                    setState2(() {});
                                  },
                                );
                                MainPage.ad.initRewardedAd();
                              } else {
                                if (hintIndex[0] < 3) hintIndex[0]++;
                                print(hintIndex[0]);
                                setState2(() {});
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.purple,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Open hint',
                                    textAlign: TextAlign.center,
                                    style: generateStyle(
                                      FontWeight.w500,
                                      MyColors.white,
                                      MySize.alertButton,
                                    ),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: MyColors.white,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  cover: Container(
                    child: CircleAvatar(
                      backgroundColor: MyColors.purple,
                      radius: 50,
                      // child: Image.asset(
                      //   'assets/images/lmp.png',
                      //   width: 60,
                      //   height: 60,
                      // ),
                      child: SvgPicture.asset(
                        'assets/images/lamp.svg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  children: List.generate(
                    hintIndex[0],
                    (index) => hints[index],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
