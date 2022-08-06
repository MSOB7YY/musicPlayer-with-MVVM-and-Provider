import 'package:flutter/material.dart';
import 'package:music_player_app/home/view/widgets/icon_buttons.dart';
import 'package:music_player_app/playing_music/view/widgets/duration_state_widget.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';

class MiniNullWidget extends StatelessWidget {
  const MiniNullWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BodyContainer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: const DurationStateWidget(
              barHeight: 3,
              thumbRadius: 2,
            ),
          ),
          ListTile(
            leading: Image.asset(
              "assets/malhaarNew3Logo.png",
            ),
            title: Text(
              "Music Player",
              style: TextStyle(
                color: kWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Text(
              "Artist",
              style: TextStyle(
                color: kWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: const IconButtons(
              icon: Icons.play_arrow,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }
}
