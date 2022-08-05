import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';

class DrawerIcons extends StatelessWidget {
  const DrawerIcons({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: kWhite,
    );
  }
}
