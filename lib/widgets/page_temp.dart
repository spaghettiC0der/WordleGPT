import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/data/text_sizes.dart';
import 'package:proj3/functions/generate_font_style.dart';

import '../data/player.dart';

class PageTemp extends StatelessWidget {
  final String title;
  final List<Widget> list;
  final InkWell inkWell;
  final InkWell inkWell2;
  final bool isStoryMode;
  final bool backButton;
  PageTemp({
    super.key,
    required this.title,
    required this.list,
    this.inkWell = const InkWell(
      child: Icon(
        Icons.abc,
        color: Colors.transparent,
      ),
    ),
    this.inkWell2 = const InkWell(
      child: Icon(
        Icons.abc,
        color: Colors.transparent,
      ),
    ),
    this.isStoryMode = false,
    this.backButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: MyColors.backgroundColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: isStoryMode
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // color: Colors.indigo,
                height: 90,
                padding: EdgeInsets.only(
                  top: 15,
                  left: 25,
                  right: 25,
                  bottom: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    backButton
                        ? InkWell(
                            onTap: () {
                              Player.tabPlay();
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(3),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: MyColors.white,
                              ),
                            ),
                          )
                        : inkWell2,
                    Container(
                      width: 240,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColors.secondaryBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        title,
                        style: generateStyle(
                          FontWeight.w700,
                          MyColors.white,
                          MySize.header,
                        ),
                      ),
                    ),
                    inkWell,
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: list,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
