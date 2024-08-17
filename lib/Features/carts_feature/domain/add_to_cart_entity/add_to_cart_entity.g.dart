// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddToCartEntityAdapter extends TypeAdapter<AddToCartEntity> {
  @override
  final int typeId = 3;

  @override
  AddToCartEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddToCartEntity(
      id: fields[0] as dynamic,
      price: fields[1] as dynamic,
      oldPrice: fields[2] as dynamic,
      discount: fields[3] as dynamic,
      image: fields[4] as dynamic,
      name: fields[5] as dynamic,
      description: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AddToCartEntity obj) {
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
      other is AddToCartEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
