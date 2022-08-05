// ignore_for_file: deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerProvider with ChangeNotifier {
  Future<void> email() async {
    if (await launch('mailto:pranavpv257@gmail.com')) {
      throw "Try Again";
    }
  }

  Future<void> about() async {
    if (await launch('https://pranavpv773.github.io/pranav-s/')) {
      throw "Try Again";
    }
  }

  Future<void> share() async {
    Share.share(
        "Hey! check out this new app https://play.google.com/store/apps/details?id=in.brototype.malhaar");
  }
}
