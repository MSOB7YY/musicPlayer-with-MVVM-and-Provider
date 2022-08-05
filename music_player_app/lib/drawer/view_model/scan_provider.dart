// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_player_app/utilities/view/core.dart';

class ScanProvider with ChangeNotifier {
  late AnimationController animationController;
  bool isplaying = false;

  String scan = 'scan';
  boolText() {
    if (isplaying == true) {
      scan = 'scanning...';
    }
  }

  RotationTransition buildRotationTransition(BuildContext context) {
    return RotationTransition(
      turns: animationController,
      child: ClipOval(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 200,
          decoration: BoxDecoration(
            gradient: SweepGradient(
              colors: [
                const Color.fromARGB(255, 66, 64, 64).withOpacity(0.2),
                kWhite.withOpacity(0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
