import 'package:flutter/material.dart';
import 'package:proj3/data/colors.dart';
import 'package:proj3/models/key_model.dart';

import '../data/player.dart';
import '../data/text_sizes.dart';
import '../functions/generate_font_style.dart';

class KeyB extends StatefulWidget {
  final KeyData data;
  final Function fun;
  const KeyB({
    super.key,
    required this.data,
    required this.fun,
  });

  @override
  State<KeyB> createState() => _KeyBState(
        data: data,
        fun: fun,
      );
}

class _KeyBState extends State<KeyB> {
  final KeyData data;
  final Function fun;
  bool isPressed = false;
  _KeyBState({required this.data, required this.fun});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Player.keyPlay();
        isPressed = true;
        setState(() {});
        await Future.delayed(Duration(milliseconds: 100));
        isPressed = false;
        setState(() {});
        fun(data);
      },
      child: Container(
        width: data.type == 2
            ? 60
            : data.type == 3
                ? 40
                : 30,
        height: 45,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 3,
        ),
        decoration: BoxDecoration(
          color: isPressed
              ? MyColors.white
              : data.state == 1
                  ? MyColors.greyForButtons
                  : data.state == 2
                      ? MyColors.greyFailedForKeyboard
                      : data.state == 3
                          ? MyColors.green
                          : data.state == 4
                              ? MyColors.yellow
                              : MyColors.purple,
          borderRadius: BorderRadius.circular(6),
        ),
        child: data.type != 3
            ? Text(
                data.letter,
                style: generateStyle(
                  isPressed ? FontWeight.w500 : FontWeight.normal,
                  isPressed ? Colors.black : MyColors.white,
                  data.type == 2 ? MySize.enter : MySize.keyboard,
                ),
              )
            : Icon(
                data.icon,
                color: MyColors.white,
              ),
      ),
    );
  }
}
