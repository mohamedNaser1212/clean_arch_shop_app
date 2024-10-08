// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoriesEntityAdapter extends TypeAdapter<CategoriesEntity> {
  @override
  final int typeId = 1;

  @override
  CategoriesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoriesEntity(
      name: fields[0] as String,
      image: fields[1] as String,
      id: fields[2] as num,
    );
  }

  @override
  void write(BinaryWriter writer, CategoriesEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoriesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
