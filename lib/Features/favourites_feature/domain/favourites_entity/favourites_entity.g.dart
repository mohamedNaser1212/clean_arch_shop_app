// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavouritesEntityAdapter extends TypeAdapter<FavouritesEntity> {
  @override
  final int typeId = 2;

  @override
  FavouritesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return FavouritesEntity(
      id: fields[0] as num,
      price: fields[1] as num,
      oldPrice: fields[2] as num,
      discount: fields[3] as num,
      image: fields[4] as String,
      name: fields[5] as String,
      description: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritesEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.oldPrice)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
