// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

// class UserAdapter extends TypeAdapter<User> {
//   @override
//   final int typeId = 0;
//
//   @override
//   User read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return User(
//       userId: fields[0] as dynamic,
//       name: fields[1] as dynamic,
//       login: fields[2] as dynamic,
//       birthday: fields[3] as dynamic,
//       email: fields[4] as dynamic,
//       phone: fields[6] as dynamic,
//       password: fields[5] as dynamic,
//       type: fields[7] as dynamic,
//       car: fields[8] as dynamic,
//       token: fields[9] as dynamic,
//       renewalToken: fields[10] as dynamic,
//       photo: fields[11] as dynamic,
//       cars: fields[12] as dynamic,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, User obj) {
//     writer
//       ..writeByte(13)
//       ..writeByte(0)
//       ..write(obj.userId)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.login)
//       ..writeByte(3)
//       ..write(obj.birthday)
//       ..writeByte(4)
//       ..write(obj.email)
//       ..writeByte(5)
//       ..write(obj.password)
//       ..writeByte(6)
//       ..write(obj.phone)
//       ..writeByte(7)
//       ..write(obj.type)
//       ..writeByte(8)
//       ..write(obj.car)
//       ..writeByte(9)
//       ..write(obj.token)
//       ..writeByte(10)
//       ..write(obj.renewalToken)
//       ..writeByte(11)
//       ..write(obj.photo)
//       ..writeByte(12)
//       ..write(obj.cars);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
