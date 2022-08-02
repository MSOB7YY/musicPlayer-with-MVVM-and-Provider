// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/view/home_screen.dart';
import '../../utilities/colors.dart';
import 'widgets/scan_screen.dart';

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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.bottomRight,
                colors: [
                  background1,
                  background2,
                ],
              ),
            ),
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
                  title: const Text(
                    'Library',
                    style: TextStyle(
                      color: Colors.white,
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
                  leading: const Icon(
                    Icons.feedback_sharp,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Feedback',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () => {
                    _email(),
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.laptop,
                    color: Colors.white,
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
