import 'package:flutter/material.dart';

class IconsSubContainers extends StatelessWidget {
  final Widget widget;
  const IconsSubContainers({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(64, 225, 224, 231),
      height: 40,
      width: 40,
      child: widget,
    );
  }
}
