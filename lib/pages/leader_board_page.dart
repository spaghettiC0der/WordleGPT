import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/profile.dart';
import 'package:proj3/main.dart';
import 'package:proj3/widgets/normal_user_profile.dart';
import 'package:proj3/widgets/page_temp.dart';
import 'package:proj3/widgets/top_user_profile.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';
import 'dart:math' as math;

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  var profileList = [];

  // void initState() {}
  int lookUp() {
    int sz = profileList.length;
    for (int i = 0; i < sz; i++) {
      if (profileList[i]['id'] == MyApp.myData.get('userId')) return i + 1;
    }
    throw Exception('eoo');
  }

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Leaderboard',
      list: [
        Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .orderBy(
                    'score',
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('error');
                }
                if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  profileList = [];
                  for (var i in data) {
                    profileList.add(i);
                  }
                  // profileList.sort(
                  //   (a, b) {
                  //     double aa = ProfileInfo.conv(a['score'].toString());
                  //     double bb = ProfileInfo.conv(b['score'].toString());
                  //     return bb.compareTo(aa);
                  //   },
                  // );
                  ProfileInfo.setData(
                    id: MyApp.myData.get('userId'),
                    preRank: ProfileInfo.preRank == 0
                        ? lookUp()
                        : ProfileInfo.recentRank,
                    recentRank: lookUp(),
                    bestRank: ProfileInfo.bestRank == 0
                        ? lookUp()
                        : math.min(ProfileInfo.bestRank, lookUp()),
                  );
                  for (int i = 0; i < profileList.length; i++) {
                    print(profileList[i]['score']);
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 50,
                            ),
                            child: TopUserProfile(
                              name: profileList[1]['id'],
                              score: double.parse(ProfileInfo.conv(
                                      profileList[1]['score'].toString())
                                  .toStringAsFixed(1)),
                              // name: profilesData[1].name,
                              // image: profilesData[1].image,
                              imageIndex: profileList[1]['avatar'],
                              // score: profilesData[1].score,
                              borderColor: MyColors.silver,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 50,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    MdiIcons.crown,
                                    size: 30,
                                    color: MyColors.gold,
                                  ),
                                ),
                                TopUserProfile(
                                  name: profileList[0]['id'],
                                  // score: profileList[0]['score'],
                                  score: double.parse(ProfileInfo.conv(
                                          profileList[0]['score'].toString())
                                      .toStringAsFixed(1)),
                                  // name: profilesData[0].name,
                                  imageIndex: profileList[0]['avatar'],
                                  // score: profilesData[0].score,
                                  borderColor: MyColors.gold,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 50,
                            ),
                            child: TopUserProfile(
                              name: profileList[2]['id'],
                              // score: profileList[2]['score'],
                              score: double.parse(ProfileInfo.conv(
                                      profileList[2]['score'].toString())
                                  .toStringAsFixed(1)),
                              // name: profilesData[2].name,
                              imageIndex: profileList[2]['avatar'],
                              // score: profilesData[2].score,
                              borderColor: MyColors.bronze,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryBackgroundColor,
                        ),
                        margin: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                'Your current rank',
                                style: generateStyle(
                                  FontWeight.normal,
                                  MyColors.white,
                                  MySize.leaderboardText,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      '${ProfileInfo.recentRank}',
                                      style: generateStyle(
                                        FontWeight.normal,
                                        MyColors.white,
                                        MySize.leaderboardText,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    ProfileInfo.recentRank >=
                                            ProfileInfo.preRank
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    color: ProfileInfo.recentRank >=
                                            ProfileInfo.preRank
                                        ? MyColors.green
                                        : MyColors.red,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: List.generate(
                            profileList.length - 3,
                            (index) {
                              // ProfileInfo.setData(
                              //   preRank: ProfileInfo.preRank == 0
                              //       ? index + 4
                              //       : ProfileInfo.recentRank,
                              //   recentRank: index + 4,
                              //   bestRank: ProfileInfo.bestRank == 0
                              //       ? index + 4
                              //       : math.min(ProfileInfo.bestRank, index + 4),
                              // );
                              return NormalUserProfile(
                                idx: index + 3,
                                name: profileList[index + 3]['id'],
                                score: ProfileInfo.conv(profileList[index + 3]
                                        ['score']
                                    .toStringAsFixed(1)),
                                imageIndex: profileList[index + 3]['avatar'],
                                isImproved: profileList[index + 3]
                                        ['recentRank'] <=
                                    profileList[index + 3]['preRank'],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                throw Exception('dd');
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(
            //         top: 50,
            //       ),
            //       child: TopUserProfile(
            //         name: profileList[1]['id'],
            //         score: profileList[1]['score'],
            //         // name: profilesData[1].name,
            //         image: profilesData[1].image,
            //         // score: profilesData[1].score,
            //         borderColor: MyColors.silver,
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(
            //         bottom: 50,
            //       ),
            //       child: Column(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(4.0),
            //             child: Icon(
            //               MdiIcons.crown,
            //               size: 30,
            //               color: MyColors.gold,
            //             ),
            //           ),
            //           TopUserProfile(
            //             name: profileList[0]['id'],
            //             score: profileList[0]['score'],
            //             // name: profilesData[0].name,
            //             image: profilesData[0].image,
            //             // score: profilesData[0].score,
            //             borderColor: MyColors.gold,
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.only(
            //         top: 50,
            //       ),
            //       child: TopUserProfile(
            //         name: profileList[2]['id'],
            //         score: profileList[2]['score'],
            //         // name: profilesData[2].name,
            //         image: profilesData[2].image,
            //         // score: profilesData[2].score,
            //         borderColor: MyColors.bronze,
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   width: 350,
            //   height: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: MyColors.secondaryBackgroundColor,
            //   ),
            //   margin: EdgeInsets.only(
            //     bottom: 20,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.symmetric(
            //           horizontal: 20,
            //           vertical: 10,
            //         ),
            //         child: Text(
            //           'Your current rating',
            //           style: generateStyle(
            //             FontWeight.normal,
            //             MyColors.white,
            //             MySize.leaderboardText,
            //           ),
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.symmetric(
            //           horizontal: 20,
            //           vertical: 10,
            //         ),
            //         child: Row(
            //           children: [
            //             Container(
            //               margin: EdgeInsets.symmetric(
            //                 horizontal: 10,
            //               ),
            //               child: Text(
            //                 '123',
            //                 style: generateStyle(
            //                   FontWeight.normal,
            //                   MyColors.white,
            //                   MySize.leaderboardText,
            //                 ),
            //               ),
            //             ),
            //             Icon(
            //               Icons.arrow_upward,
            //               color: MyColors.green,
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Column(
            //     children: List.generate(
            //       profileList.length - 3,
            //       (index) => NormalUserProfile(
            //           idx: index + 4,
            //           name: profileList[index]['id'],
            //           score: profileList[index]['score'],
            //           // name: profilesData[index + 3].name,
            //           image: profilesData[index + 3].image,
            //           // score: profilesData[index + 3].score,
            //           isImproved: true),
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
