import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class PlaylistDbModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<dynamic> songList;
  PlaylistDbModel({
    required this.name,
    this.id,
    this.songList = const [],
  });
}
