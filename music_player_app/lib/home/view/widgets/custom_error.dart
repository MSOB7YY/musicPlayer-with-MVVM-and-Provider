import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class CustomSnackBarError extends StatelessWidget {
  const CustomSnackBarError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSnackBar.error(
      iconPositionLeft: 0,
      iconPositionTop: 0,
      iconRotationAngle: 0,
      icon: Icon(
        Icons.abc,
        color: primary1,
      ),
      backgroundColor: primary1,
      message: "no Songs found ",
    );
  }
}
