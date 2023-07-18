import 'package:flutter/material.dart';
import 'package:proj3/data/categories_data.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/functions/start_story_mode.dart';
import 'package:proj3/widgets/box_story_mode.dart';
import 'package:proj3/widgets/category_item_story_mode.dart';
import 'package:proj3/widgets/page_temp.dart';
import 'package:proj3/data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class StoryMode extends StatefulWidget {
  StoryMode({super.key});
  @override
  State<StoryMode> createState() => _StoryModeState();
}

class _StoryModeState extends State<StoryMode> {
  String favTopic = '';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  int numOfWordsForEachCategory = 5;
  List<BoxStoryMode> list = [];
  addNewCat(String newCat) {
    setState(() {
      list.add(
        BoxStoryMode(
          iconData: Icons.close,
          title: newCat,
          fun: removeCat,
        ),
      );
    });
  }

  removeCat(String oldCat) {
    setState(() {
      list.removeWhere((element) => element.title == oldCat);
    });
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 30,
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        backgroundColor: MyColors.backgroundColor.withOpacity(0.9),
        content: Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Form(
                  key: _key,
                  child: TextFormField(
                    onChanged: (text) => {favTopic = text},
                    validator: (value) {
                      if (value == null || value.length == 0)
                        return 'Your topic shouldn\'t be empty';
                      if (value.length > 15) {
                        return 'Length of the topic should be less than 15';
                      }
                      return null;
                    },
                    style: generateStyle(
                      FontWeight.normal,
                      MyColors.white,
                      MySize.labelHint,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MyColors.blanckBox,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          width: 0,
                        ),
                      ),
                      hintText: 'Write down your topic',
                      hintStyle: generateStyle(
                        FontWeight.w100,
                        MyColors.whiteTrans,
                        MySize.labelHint,
                      ),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.send_rounded,
                              color: MyColors.white),
                          onPressed: list.length < 5
                              ? () {
                                  Player.tabPlay();
                                  if (_key.currentState!.validate()) {
                                    addNewCat(favTopic);
                                    Navigator.pop(context);
                                  }
                                }
                              : () {}),
                    ),
                  ),
                ),
                Wrap(
                  children: List.generate(
                    categoriesData.length,
                    (index) => CategoryItemStoryMode(
                      iconData: categoriesData[index].iconData,
                      title: categoriesData[index].title,
                      fun: addNewCat,
                      isExist: list.length > 4 ||
                          list.any((element) =>
                              element.title == categoriesData[index].title),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'Story mode',
      isStoryMode: true,
      list: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          height: MediaQuery.of(context).size.height - 115,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  // left: 30,
                                  right: 10,
                                ),
                                child: Icon(
                                  Icons.circle,
                                  color: MyColors.white,
                                  size: 12,
                                ),
                              ),
                              Text(
                                'Pick amount of words',
                                style: generateStyle(
                                  FontWeight.normal,
                                  MyColors.white,
                                  MySize.storyModeScreenText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                              onPressed: () {
                                Player.tabPlay();
                                if (numOfWordsForEachCategory > 5)
                                  setState(() {
                                    numOfWordsForEachCategory--;
                                  });
                              },
                              icon: Icon(
                                Icons.remove,
                                color: MyColors.white,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: MyColors.secondaryBackgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 50,
                              height: 50,
                              child: Center(
                                child: Text(
                                  '${numOfWordsForEachCategory}',
                                  style: generateStyle(
                                    FontWeight.w500,
                                    MyColors.white,
                                    MySize.buttonTitle,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Player.tabPlay();
                                if (numOfWordsForEachCategory < 31)
                                  setState(() {
                                    numOfWordsForEachCategory++;
                                  });
                              },
                              icon: Icon(
                                Icons.add,
                                color: MyColors.white,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            // left: 30,
                            right: 10,
                          ),
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 12,
                          ),
                        ),
                        Text(
                          'Add topics you like',
                          style: generateStyle(
                            FontWeight.normal,
                            MyColors.white,
                            MySize.storyModeScreenText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    // horizontal: 20,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: list,
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        // horizontal: 20,
                        ),
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Player.tabPlay();
                        openDialog();
                      },
                      child: BoxStoryMode(
                        iconData: Icons.add,
                        title: 'Choose some topic',
                        isButton: true,
                        fun: () => openDialog(),
                      ),
                    ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            list.length > 0
                                ? startStoryMode(
                                    context,
                                    List.generate(
                                      list.length,
                                      (index) => list[index].title,
                                    ),
                                    numOfWordsForEachCategory)
                                : null;
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            backgroundColor: list.length > 0
                                ? MyColors.green
                                : MyColors.greyFailedForKeyboard,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Start',
                                style: generateStyle(
                                  FontWeight.normal,
                                  MyColors.white,
                                  MySize.buttonTitle,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
