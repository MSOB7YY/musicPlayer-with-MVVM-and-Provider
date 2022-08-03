import 'package:flutter/material.dart';
import '../../../utilities/view/colors.dart';

class IconButtons extends StatelessWidget {
  final IconData icon;
  final double size;
  const IconButtons({Key? key, required this.icon, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: size,
        color: kAmber,
      ),
    );
  }
}
