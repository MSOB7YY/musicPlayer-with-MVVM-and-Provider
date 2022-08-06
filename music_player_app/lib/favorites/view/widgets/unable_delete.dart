import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/core.dart';

class UnableToDelete extends StatelessWidget {
  const UnableToDelete({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhite,
      content: Text(
        'Unable To delete while playing same song',
        style: TextStyle(
          color: kAmber,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: primary0),
          ),
        ),
      ],
    );
  }
}
