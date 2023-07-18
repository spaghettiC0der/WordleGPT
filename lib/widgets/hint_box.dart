import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';

import '../data/player.dart';

class HintBox extends StatelessWidget {
  HintBox({
    this.title = '',
    required this.angle1,
    required this.btn,
    required this.cover,
    required this.children,
    this.fin = false,
    this.isHint = false,
  });
  final String title;
  final Container angle1;
  final Container cover;
  final Container btn;
  final List<Widget> children;
  final bool fin;
  final bool isHint;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        padding: EdgeInsets.all(
          10,
        ),
        color: Colors.transparent,
        child: Stack(
          children: [
            //box content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //empty area
                Container(
                  color: Colors.transparent,
                  height: 50,
                ),
                //real content
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: angle1,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 15,
                              right: 15,
                            ),
                            child: InkWell(
                              onTap: () {
                                Player.tabPlay();
                                Navigator.pop(context);
                                if (!isHint) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                Icons.close,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // if (fin)
                      //   title,
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                          left: 15,
                          bottom: 15,
                          right: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: fin
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: children,
                        ),
                      ),
                      btn,
                    ],
                  ),
                ),
              ],
            ),

            //circle
            Container(
              height: 100,
              alignment: Alignment.topCenter,
              child: cover,
            ),
          ],
        ),
      ),
    );
  }
}
