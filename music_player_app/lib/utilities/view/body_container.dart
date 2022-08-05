import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;
  const BodyContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            colors: [
              primary0,
              primary1,
            ],
          ),
        ),
        child: child);
  }
}
