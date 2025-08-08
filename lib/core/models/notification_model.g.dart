// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final int typeId = 5;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      title: fields[1] as String,
      message: fields[2] as String,
      type: fields[3] as String,
      isRead: fields[4] as bool,
      data: (fields[5] as Map?)?.cast<String, dynamic>(),
      createdAt: fields[6] as DateTime,
      readAt: fields[7] as DateTime?,
      lastSyncAt: fields[8] as DateTime?,
      isLocalOnly: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isRead)
      ..writeByte(5)
      ..write(obj.data)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.readAt)
      ..writeByte(8)
      ..write(obj.lastSyncAt)
      ..writeByte(9)
      ..write(obj.isLocalOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      isRead: json['isRead'] as bool,
      data: json['data'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
      isLocalOnly: json['isLocalOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'isRead': instance.isRead,
      'data': instance.data,
      'createdAt': instance.createdAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
      'isLocalOnly': instance.isLocalOnly,
    };
