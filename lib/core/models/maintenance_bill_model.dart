import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'maintenance_bill_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MaintenanceBillModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final double amount;
  
  @HiveField(2)
  final DateTime dueDate;
  
  @HiveField(3)
  final String status;
  
  @HiveField(4)
  final String billType;
  
  @HiveField(5)
  final int billMonth;
  
  @HiveField(6)
  final int billYear;
  
  @HiveField(7)
  final DateTime? paymentDate;
  
  @HiveField(8)
  final String? paymentMethod;
  
  @HiveField(9)
  final String? transactionId;
  
  @HiveField(10)
  final RoomInfo room;
  
  @HiveField(11)
  final SocietyInfo society;
  
  @HiveField(12)
  final List<BillComponent> components;
  
  @HiveField(13)
  final String? notes;
  
  @HiveField(14)
  final DateTime createdAt;
  
  @HiveField(15)
  final DateTime? lastSyncAt;
  
  @HiveField(16)
  final bool isLocalOnly;

  const MaintenanceBillModel({
    required this.id,
    required this.amount,
    required this.dueDate,
    required this.status,
    required this.billType,
    required this.billMonth,
    required this.billYear,
    this.paymentDate,
    this.paymentMethod,
    this.transactionId,
    required this.room,
    required this.society,
    required this.components,
    this.notes,
    required this.createdAt,
    this.lastSyncAt,
    this.isLocalOnly = false,
  });

  factory MaintenanceBillModel.fromJson(Map<String, dynamic> json) => 
      _$MaintenanceBillModelFromJson(json);
  Map<String, dynamic> toJson() => _$MaintenanceBillModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        amount,
        dueDate,
        status,
        billType,
        billMonth,
        billYear,
        paymentDate,
        paymentMethod,
        transactionId,
        room,
        society,
        components,
        notes,
        createdAt,
        lastSyncAt,
        isLocalOnly,
      ];
}

@HiveType(typeId: 2)
@JsonSerializable()
class RoomInfo extends Equatable {
  @HiveField(0)
  final String roomNumber;
  
  @HiveField(1)
  final String roomType;
  
  @HiveField(2)
  final double? area;

  const RoomInfo({
    required this.roomNumber,
    required this.roomType,
    this.area,
  });

  factory RoomInfo.fromJson(Map<String, dynamic> json) => _$RoomInfoFromJson(json);
  Map<String, dynamic> toJson() => _$RoomInfoToJson(this);

  @override
  List<Object?> get props => [roomNumber, roomType, area];
}

@HiveType(typeId: 3)
@JsonSerializable()
class SocietyInfo extends Equatable {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String? contactEmail;

  const SocietyInfo({
    required this.name,
    this.contactEmail,
  });

  factory SocietyInfo.fromJson(Map<String, dynamic> json) => _$SocietyInfoFromJson(json);
  Map<String, dynamic> toJson() => _$SocietyInfoToJson(this);

  @override
  List<Object?> get props => [name, contactEmail];
}

@HiveType(typeId: 4)
@JsonSerializable()
class BillComponent extends Equatable {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final double amount;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String applicableFor;

  const BillComponent({
    required this.name,
    required this.amount,
    required this.description,
    required this.applicableFor,
  });

  factory BillComponent.fromJson(Map<String, dynamic> json) => _$BillComponentFromJson(json);
  Map<String, dynamic> toJson() => _$BillComponentToJson(this);

  @override
  List<Object?> get props => [name, amount, description, applicableFor];
}