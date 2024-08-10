// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'product_entity.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
//   @override
//   final int typeId = 0;
//
//   @override
//   ProductEntity read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return ProductEntity(
//       id: fields[0] as num,
//       name: fields[1] as String,
//       discount: fields[2] as num,
//       oldPrice: fields[4] as num,
//       price: fields[3] as num,
//       image: fields[5] as String,
//       images: (fields[6] as List).cast<String>(),
//       description: fields[7] as String?,
//       inFavorites: fields[8] as bool,
//       inCart: fields[9] as bool?,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, ProductEntity obj) {
//     writer
//       ..writeByte(10)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.discount)
//       ..writeByte(3)
//       ..write(obj.price)
//       ..writeByte(4)
//       ..write(obj.oldPrice)
//       ..writeByte(5)
//       ..write(obj.image)
//       ..writeByte(6)
//       ..write(obj.images)
//       ..writeByte(7)
//       ..write(obj.description)
//       ..writeByte(8)
//       ..write(obj.inFavorites)
//       ..writeByte(9)
//       ..write(obj.inCart);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is ProductEntityAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
