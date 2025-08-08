// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaintenanceBillModelAdapter extends TypeAdapter<MaintenanceBillModel> {
  @override
  final int typeId = 1;

  @override
  MaintenanceBillModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaintenanceBillModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      dueDate: fields[2] as DateTime,
      status: fields[3] as String,
      billType: fields[4] as String,
      billMonth: fields[5] as int,
      billYear: fields[6] as int,
      paymentDate: fields[7] as DateTime?,
      paymentMethod: fields[8] as String?,
      transactionId: fields[9] as String?,
      room: fields[10] as RoomInfo,
      society: fields[11] as SocietyInfo,
      components: (fields[12] as List).cast<BillComponent>(),
      notes: fields[13] as String?,
      createdAt: fields[14] as DateTime,
      lastSyncAt: fields[15] as DateTime?,
      isLocalOnly: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MaintenanceBillModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.billType)
      ..writeByte(5)
      ..write(obj.billMonth)
      ..writeByte(6)
      ..write(obj.billYear)
      ..writeByte(7)
      ..write(obj.paymentDate)
      ..writeByte(8)
      ..write(obj.paymentMethod)
      ..writeByte(9)
      ..write(obj.transactionId)
      ..writeByte(10)
      ..write(obj.room)
      ..writeByte(11)
      ..write(obj.society)
      ..writeByte(12)
      ..write(obj.components)
      ..writeByte(13)
      ..write(obj.notes)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.lastSyncAt)
      ..writeByte(16)
      ..write(obj.isLocalOnly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaintenanceBillModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoomInfoAdapter extends TypeAdapter<RoomInfo> {
  @override
  final int typeId = 2;

  @override
  RoomInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoomInfo(
      roomNumber: fields[0] as String,
      roomType: fields[1] as String,
      area: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, RoomInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.roomNumber)
      ..writeByte(1)
      ..write(obj.roomType)
      ..writeByte(2)
      ..write(obj.area);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SocietyInfoAdapter extends TypeAdapter<SocietyInfo> {
  @override
  final int typeId = 3;

  @override
  SocietyInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocietyInfo(
      name: fields[0] as String,
      contactEmail: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SocietyInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contactEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocietyInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BillComponentAdapter extends TypeAdapter<BillComponent> {
  @override
  final int typeId = 4;

  @override
  BillComponent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillComponent(
      name: fields[0] as String,
      amount: fields[1] as double,
      description: fields[2] as String,
      applicableFor: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillComponent obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.applicableFor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillComponentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceBillModel _$MaintenanceBillModelFromJson(
        Map<String, dynamic> json) =>
    MaintenanceBillModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: json['status'] as String,
      billType: json['billType'] as String,
      billMonth: (json['billMonth'] as num).toInt(),
      billYear: (json['billYear'] as num).toInt(),
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      transactionId: json['transactionId'] as String?,
      room: RoomInfo.fromJson(json['room'] as Map<String, dynamic>),
      society: SocietyInfo.fromJson(json['society'] as Map<String, dynamic>),
      components: (json['components'] as List<dynamic>)
          .map((e) => BillComponent.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
      isLocalOnly: json['isLocalOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$MaintenanceBillModelToJson(
        MaintenanceBillModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'dueDate': instance.dueDate.toIso8601String(),
      'status': instance.status,
      'billType': instance.billType,
      'billMonth': instance.billMonth,
      'billYear': instance.billYear,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'transactionId': instance.transactionId,
      'room': instance.room,
      'society': instance.society,
      'components': instance.components,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
      'isLocalOnly': instance.isLocalOnly,
    };

RoomInfo _$RoomInfoFromJson(Map<String, dynamic> json) => RoomInfo(
      roomNumber: json['roomNumber'] as String,
      roomType: json['roomType'] as String,
      area: (json['area'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RoomInfoToJson(RoomInfo instance) => <String, dynamic>{
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'area': instance.area,
    };

SocietyInfo _$SocietyInfoFromJson(Map<String, dynamic> json) => SocietyInfo(
      name: json['name'] as String,
      contactEmail: json['contactEmail'] as String?,
    );

Map<String, dynamic> _$SocietyInfoToJson(SocietyInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contactEmail': instance.contactEmail,
    };

BillComponent _$BillComponentFromJson(Map<String, dynamic> json) =>
    BillComponent(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      applicableFor: json['applicableFor'] as String,
    );

Map<String, dynamic> _$BillComponentToJson(BillComponent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'description': instance.description,
      'applicableFor': instance.applicableFor,
    };
