import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proj3/widgets/page_temp.dart';

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemp(
      title: 'The rules',
      list: [
        Container(
          child: SvgPicture.asset(
            'assets/images/help.svg',
            width: MediaQuery.of(context).size.width - 5,
            height: MediaQuery.of(context).size.height - 115,
          ),
        ),
      ],
    );
  }
}
