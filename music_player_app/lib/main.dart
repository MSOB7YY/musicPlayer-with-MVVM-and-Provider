import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player_app/playlist/model/playlist_model.dart';
import 'favorites/model/favourite_model.dart';
import 'spalsh/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlaylistDbModelAdapter().typeId)) {
    Hive.registerAdapter(
      PlaylistDbModelAdapter(),
    );
  }
  if (!Hive.isAdapterRegistered(FavoriteDbModelAdapter().typeId)) {
    Hive.registerAdapter(
      FavoriteDbModelAdapter(),
    );
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }

  runApp(const Music());
}

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
