import 'package:flutter/material.dart';
import 'package:proj3/widgets/key.dart';

import '../data/keys_data.dart';

class Keyboard extends StatelessWidget {
  final Function fun;
  const Keyboard({super.key, required this.fun});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keyDataList
            .map(
              (x) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: x.map((y) {
                  return KeyB(
                    data: y,
                    fun: fun,
                  );
                }).toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}
