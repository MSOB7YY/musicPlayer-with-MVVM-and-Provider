import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class CustomSnackBarSuccess extends StatelessWidget {
  const CustomSnackBarSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSnackBar.success(
      iconPositionLeft: 0,
      iconPositionTop: 0,
      iconRotationAngle: 0,
      icon: Icon(
        Icons.abc,
        color: kAmber,
      ),
      backgroundColor: kAmber,
      message: "Songs Scanned",
    );
  }
}
