
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/player.dart';
import 'package:proj3/data/profile.dart';
import 'package:proj3/main.dart';
import 'package:proj3/widgets/start_box.dart';

import '../data/text_sizes.dart';
import '../functions/ads.dart';
import '../functions/generate_font_style.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});
  static final AdServices ad = AdServices();
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isMuted = MyApp.myData.get('sound') == 1? false: true;
  void initState() {
    MainPage.ad.initBannerAd();
    MainPage.ad.initInterstitialAd();
    MainPage.ad.initRewardedAd();

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            bottom: 0,
            top: 20,
            // left: 10,
            // right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/main.png',
                  width: 300,
                  height: 100,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        '${ProfileInfo.win}',
                        style: generateStyle(
                          FontWeight.w500,
                          MyColors.white,
                          MySize.bigNum,
                        ),
                      ),
                      Text(
                        'Wins',
                        style: generateStyle(
                          FontWeight.w500,
                          MyColors.green,
                          MySize.screenText,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${ProfileInfo.lose}',
                        style: generateStyle(
                          FontWeight.w500,
                          MyColors.white,
                          MySize.bigNum,
                        ),
                      ),
                      Text(
                        'Loses',
                        style: generateStyle(
                          FontWeight.w500,
                          MyColors.red,
                          MySize.screenText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),

              //buttons
              Container(
                margin: EdgeInsets.only(
                  bottom: 80,
                  // left: 5,
                  // right: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 40,
                        left: 15,
                      ),
                      child: BoxStart(
                        icon: MdiIcons.podiumGold,
                        moveTo: '/leader-board',
                        size: 70,
                      ),
                    ),
                    Column(
                      children: [
                        BoxStart(
                          icon: Icons.play_arrow_rounded,
                          moveTo: '/difficulty',
                          size: 140,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 50,
                          ),
                          width: 180,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.greyForButtons,
                              shape: StadiumBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: MyColors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await Player.tabPlay();
                              Navigator.pushNamed(
                                context,
                                '/story-mode',
                              );
                            },
                            child: Text(
                              'Story mode',
                              style: generateStyle(
                                FontWeight.w500,
                                MyColors.white,
                                MySize.buttonTitle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 40,
                        right: 15,
                      ),
                      child: BoxStart(
                        icon: Icons.emoji_events,
                        moveTo: '/achievements',
                        size: 70,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Player.tabPlay();
                      Navigator.pushNamed(context, '/help');
                    },
                    child: Icon(
                      Icons.help_outline_outlined,
                      size: 50,
                      color: MyColors.white,
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.settings_outlined,
                      size: 50,
                      color: MyColors.white,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState2) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Player.tabPlay();
                                      if (!isMuted) {
                                        MyApp.myData.put('sound', 0);
                                        isMuted = true;
                                        setState(() {
                                          Player.backgroundMute();
                                        });
                                        setState2(() {});
                                      } else {
                                        MyApp.myData.put('sound', 1);
                                        isMuted = false;
                                        setState(() {
                                          Player.backgroundPlay();
                                        });
                                        setState2(() {});
                                      }
                                    },
                                    child: Icon(
                                      isMuted
                                          ? Icons.volume_off
                                          : Icons.volume_up,
                                      size: 50,
                                      color: MyColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Player.tabPlay();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    'Sound effects obtained from'),
                                                Text(
                                                  ' https://www.zapsplat.com',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'Credit',
                                      style: generateStyle(
                                        FontWeight.w500,
                                        MyColors.white,
                                        MySize.alertTitle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
