import 'package:flutter/material.dart';

import 'colors.dart';

class MainTextWidget extends StatelessWidget {
  final String title;
  Color? color;
  MainTextWidget({Key? key, required this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: color ?? kWhite,
      ),
    );
  }
}
