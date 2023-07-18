import 'package:flutter/material.dart';

class KeyData {
  int state;
  final int type;
  final String letter;
  final IconData icon;
  /*
    states:
    1 - inactiva
    2 - active and not correct
    3 - active and correct
    4 - active and semi correct
    5 - ready to submit (for enter button)

    type
    1 - letter
    2 - enter button
    3 - backspace button
  */
  KeyData({
    this.state = 1,
    this.type = 1,
    this.letter = '',
    this.icon = Icons.abc,
  });
}
