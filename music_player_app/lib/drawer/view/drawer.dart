// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:music_player_app/utilities/view/body_container.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../home/view/home_screen.dart';
import '../../utilities/view/colors.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
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
                    color: background1,
                    image: const DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        'assets/malhaarNew3Logo.png',
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
                  leading: const Icon(
                    Icons.library_music,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Library',
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const MusicHome(),
                      ),
                    )
                  },
                ),
                // ListTile(
                //   leading: Icon(
                //     Icons.recycling,
                //     color: kWhite,
                //   ),
                //   title: Text(
                //     'Scan Music',
                //     style: TextStyle(
                //       color: kWhite,
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (ctx) => const ScanScreen(),
                //       ),
                //     );
                //   },
                //   // trailing: ,
                // ),
                ListTile(
                  leading: Icon(
                    Icons.feedback_sharp,
                    color: kWhite,
                  ),
                  title: Text(
                    'Feedback',
                    style: TextStyle(
                      color: kWhite,
                    ),
                  ),
                  onTap: () => {
                    _email(),
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.laptop,
                    color: kWhite,
                  ),
                  title: const Text(
                    'About Developer',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    _about(),
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'share App',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    Share.share(
                        "Hey! check out this new app https://play.google.com/store/apps/details?id=in.brototype.malhaar");
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.music_video,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Version',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    "   2.0",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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

  Future<void> _email() async {
    if (await launch('mailto:pranavpv257@gmail.com')) {
      throw "Try Again";
    }
  }

  Future<void> _about() async {
    if (await launch('https://pranavpv773.github.io/pranav-s/')) {
      throw "Try Again";
    }
  }
}
