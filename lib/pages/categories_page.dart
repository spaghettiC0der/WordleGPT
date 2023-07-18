import 'package:flutter/material.dart';
import 'package:proj3/data/categories_data.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/functions/start_play.dart';
import 'package:proj3/models/first_page_argument.dart';
import 'package:proj3/widgets/category_item.dart';
import 'package:proj3/widgets/page_temp.dart';

import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class CategoriesPage extends StatelessWidget {
  String favTopic = '';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments as FirstPageArgument;
    return GestureDetector(
      onTap: () {
        Player.tabPlay();
        FocusScope.of(context).unfocus();
      },
      child: PageTemp(
        title: 'Choose topic',
        list: [
          Container(
            // color: Colors.amber,
            height: MediaQuery.of(context).size.height - 115,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
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
                          onPressed: () {
                            Player.tabPlay();
                            if (_key.currentState!.validate()) {
                              startPlaying(context, favTopic, arg.diff);
                            }
                          }),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(
                    20,
                  ),
                  child: Text(
                    'Or',
                    style: generateStyle(
                      FontWeight.w500,
                      MyColors.white,
                      MySize.screenText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Wrap(
                  children: List.generate(
                    categoriesData.length,
                    (index) => CategoryItem(
                      title: categoriesData[index].title,
                      iconData: categoriesData[index].iconData,
                      arg: arg,
                      idx: index,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
