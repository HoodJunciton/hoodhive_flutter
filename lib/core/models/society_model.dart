import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'society_model.g.dart';

@JsonSerializable()
class SocietyModel extends Equatable {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String? description;
  final String? imageUrl;
  final int totalUnits;
  final int occupiedUnits;
  final List<String> amenities;
  final DateTime createdAt;
  final bool isActive;

  const SocietyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    this.description,
    this.imageUrl,
    required this.totalUnits,
    required this.occupiedUnits,
    required this.amenities,
    required this.createdAt,
    required this.isActive,
  });

  factory SocietyModel.fromJson(Map<String, dynamic> json) => _$SocietyModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocietyModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        city,
        state,
        pincode,
        description,
        imageUrl,
        totalUnits,
        occupiedUnits,
        amenities,
        createdAt,
        isActive,
      ];
}

@JsonSerializable()
class UnitModel extends Equatable {
  final String id;
  final String societyId;
  final String unitNumber;
  final String block;
  final String floor;
  final UnitType type;
  final double area;
  final int bedrooms;
  final int bathrooms;
  final bool isOccupied;
  final String? currentResidentId;
  final double monthlyMaintenance;

  const UnitModel({
    required this.id,
    required this.societyId,
    required this.unitNumber,
    required this.block,
    required this.floor,
    required this.type,
    required this.area,
    required this.bedrooms,
    required this.bathrooms,
    required this.isOccupied,
    this.currentResidentId,
    required this.monthlyMaintenance,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);
  Map<String, dynamic> toJson() => _$UnitModelToJson(this);

  String get displayName => '$block-$unitNumber';

  @override
  List<Object?> get props => [
        id,
        societyId,
        unitNumber,
        block,
        floor,
        type,
        area,
        bedrooms,
        bathrooms,
        isOccupied,
        currentResidentId,
        monthlyMaintenance,
      ];
}

enum UnitType {
  @JsonValue('1BHK')
  oneBHK,
  @JsonValue('2BHK')
  twoBHK,
  @JsonValue('3BHK')
  threeBHK,
  @JsonValue('4BHK')
  fourBHK,
  @JsonValue('STUDIO')
  studio,
  @JsonValue('PENTHOUSE')
  penthouse,
}

extension UnitTypeExtension on UnitType {
  String get displayName {
    switch (this) {
      case UnitType.oneBHK:
        return '1 BHK';
      case UnitType.twoBHK:
        return '2 BHK';
      case UnitType.threeBHK:
        return '3 BHK';
      case UnitType.fourBHK:
        return '4 BHK';
      case UnitType.studio:
        return 'Studio';
      case UnitType.penthouse:
        return 'Penthouse';
    }
  }
}

@JsonSerializable()
class AllocationRequestModel extends Equatable {
  final String id;
  final String userId;
  final String societyId;
  final String unitId;
  final AllocationRequestStatus status;
  final String? message;
  final DateTime requestedAt;
  final DateTime? approvedAt;
  final String? approvedBy;
  final String? rejectionReason;

  const AllocationRequestModel({
    required this.id,
    required this.userId,
    required this.societyId,
    required this.unitId,
    required this.status,
    this.message,
    required this.requestedAt,
    this.approvedAt,
    this.approvedBy,
    this.rejectionReason,
  });

  factory AllocationRequestModel.fromJson(Map<String, dynamic> json) => 
      _$AllocationRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$AllocationRequestModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        societyId,
        unitId,
        status,
        message,
        requestedAt,
        approvedAt,
        approvedBy,
        rejectionReason,
      ];
}

enum AllocationRequestStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('APPROVED')
  approved,
  @JsonValue('REJECTED')
  rejected,
}

extension AllocationRequestStatusExtension on AllocationRequestStatus {
  String get displayName {
    switch (this) {
      case AllocationRequestStatus.pending:
        return 'Pending';
      case AllocationRequestStatus.approved:
        return 'Approved';
      case AllocationRequestStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case AllocationRequestStatus.pending:
        return Colors.orange;
      case AllocationRequestStatus.approved:
        return Colors.green;
      case AllocationRequestStatus.rejected:
        return Colors.red;
    }
  }
}