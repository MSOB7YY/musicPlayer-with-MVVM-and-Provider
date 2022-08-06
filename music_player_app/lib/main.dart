import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player_app/album/view_model/album_provider.dart';
import 'package:music_player_app/all_songs/view_model/allsongs_provider.dart';
import 'package:music_player_app/artist/view_model/artist_provider.dart';
import 'package:music_player_app/drawer/view_model/scan_function.dart';
import 'package:music_player_app/drawer/view_model/scan_provider.dart';
import 'package:music_player_app/favorites/view_model/favorite_button_provider.dart';
import 'package:music_player_app/favorites/view_model/favorites_function.dart';
import 'package:music_player_app/favorites/view_model/widgets_favourites.dart';
import 'package:music_player_app/genre/view_model/genre_provider.dart';
import 'package:music_player_app/home/view_model/home_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_functions.dart';
import 'package:music_player_app/playing_music/view_model/music_utilities.dart';
import 'package:music_player_app/playlist/model/playlist_model.dart';
import 'package:music_player_app/playlist/view_model/Playlist_provider.dart/playlist_provider.dart';
import 'package:music_player_app/playlist/view_model/Playlist_provider.dart/widget_provider.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_button_fn.dart';
import 'package:music_player_app/playlist/view_model/fuctions/playlist_functions.dart';
import 'package:music_player_app/search/view_model/search_provider.dart';
import 'package:music_player_app/splash/view/splash_screen.dart';
import 'package:music_player_app/splash/view_model/splash_provider.dart';
import 'package:music_player_app/utilities/view_model/null_safety.dart';
import 'package:music_player_app/utilities/view_model/utility_provider.dart';
import 'package:provider/provider.dart';
import 'favorites/model/favourite_model.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MusicUtils(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlayMusicProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AllsongsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlaylistProviderFuctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => Playlistsongcheck(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlaylistButtonFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => WidgetProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteFunctions(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesWidget(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteButtonProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AlbumProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UtilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArtistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GenreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanFunctionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NullSafetyProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
