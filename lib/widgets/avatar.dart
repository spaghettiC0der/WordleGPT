import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  int idx;
  Avatar({super.key, required this.idx});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 100,
      backgroundColor: Colors.transparent,
      child: Image.asset(
        'assets/images/Group${idx}.png',
      ),
    );
  }
}
