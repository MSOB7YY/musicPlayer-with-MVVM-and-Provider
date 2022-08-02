import 'package:hive/hive.dart';
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

@HiveType(typeId: 2)
class FavoriteDbModel extends HiveObject {
  @HiveField(0)
  bool? isFav;

  @HiveField(1)
  int? id;

  @HiveField(2)
  String? uri;

  @HiveField(3)
  String? artist;

  @HiveField(4)
  String? title;

  @HiveField(5)
  int? image;

  FavoriteDbModel({
    required this.title,
    this.isFav,
    this.id,
    this.uri,
    this.artist,
    this.image,
  });
}
