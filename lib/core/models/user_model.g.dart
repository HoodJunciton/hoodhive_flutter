// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      email: fields[1] as String,
      phoneNumber: fields[2] as String,
      role: fields[3] as String,
      displayName: fields[4] as String,
      profilePicture: fields[5] as String?,
      isProfileActive: fields[6] as bool,
      firstName: fields[7] as String?,
      lastName: fields[8] as String?,
      aadharNumber: fields[9] as String?,
      panNumber: fields[10] as String?,
      lastSyncAt: fields[11] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.displayName)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.isProfileActive)
      ..writeByte(7)
      ..write(obj.firstName)
      ..writeByte(8)
      ..write(obj.lastName)
      ..writeByte(9)
      ..write(obj.aadharNumber)
      ..writeByte(10)
      ..write(obj.panNumber)
      ..writeByte(11)
      ..write(obj.lastSyncAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      displayName: json['displayName'] as String,
      profilePicture: json['profilePicture'] as String?,
      isProfileActive: json['isProfileActive'] as bool,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      aadharNumber: json['aadharNumber'] as String?,
      panNumber: json['panNumber'] as String?,
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'displayName': instance.displayName,
      'profilePicture': instance.profilePicture,
      'isProfileActive': instance.isProfileActive,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'aadharNumber': instance.aadharNumber,
      'panNumber': instance.panNumber,
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
    };
