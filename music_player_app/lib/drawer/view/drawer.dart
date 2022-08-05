// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:music_player_app/drawer/view/widgets/drawer_icons.dart';
import 'package:music_player_app/drawer/view/widgets/scan_screen.dart';
import 'package:music_player_app/drawer/view_model/drawer_provider.dart';
import 'package:music_player_app/home/view/home_screen.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:music_player_app/utilities/view/core.dart';
import 'package:music_player_app/utilities/view/main_text_widget.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 1.8,
        child: Drawer(
          child: BodyContainer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: primary0,
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        newLogo,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 115, left: 25),
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: const Text(
                        'MalhaaR Music',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const DrawerIcons(
                    icon: Icons.library_music,
                  ),
                  title: MainTextWidget(
                    title: 'Library',
                  ),
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const MusicHome(),
                      ),
                    )
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.recycling,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Scan Music',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ScanScreen(),
                      ),
                    );
                  },
                  // trailing: ,
                ),
                ListTile(
                  leading: const DrawerIcons(
                    icon: Icons.feedback_sharp,
                  ),
                  title: MainTextWidget(
                    title: 'Feedback',
                  ),
                  onTap: () => {
                    context.read<DrawerProvider>().email(),
                  },
                ),
                ListTile(
                  leading: const DrawerIcons(
                    icon: Icons.laptop,
                  ),
                  title: MainTextWidget(
                    title: 'About Developer',
                  ),
                  onTap: () => {
                    context.read<DrawerProvider>().about(),
                  },
                ),
                ListTile(
                  leading: const DrawerIcons(
                    icon: Icons.share_rounded,
                  ),
                  title: MainTextWidget(
                    title: 'share App',
                  ),
                  onTap: () async {
                    context.read<DrawerProvider>().share();
                  },
                ),
                ListTile(
                  leading: const DrawerIcons(
                    icon: Icons.music_video,
                  ),
                  title: MainTextWidget(
                    title: 'Version',
                  ),
                  subtitle: MainTextWidget(
                    title: "   2.0",
                  ),
                  onTap: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
