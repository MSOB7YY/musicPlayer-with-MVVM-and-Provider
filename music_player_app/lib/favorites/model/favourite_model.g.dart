// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteDbModelAdapter extends TypeAdapter<FavoriteDbModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteDbModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteDbModel(
      title: fields[4] as String?,
      isFav: fields[0] as bool?,
      id: fields[1] as int?,
      uri: fields[2] as String?,
      artist: fields[3] as String?,
      image: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteDbModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isFav)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteDbModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
