import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
  List<AudioSource> sources = [];
  for (var song in songs) {
    sources.add(
      AudioSource.uri(
        Uri.parse(song.uri!),
        tag: MediaItem(
          id: song.id.toString(),
          album: "${song.album}",
          title: song.title,
        ),
      ),
    );
  }
  return ConcatenatingAudioSource(children: sources);
}
