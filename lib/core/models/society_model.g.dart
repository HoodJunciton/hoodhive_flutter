// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyModel _$SocietyModelFromJson(Map<String, dynamic> json) => SocietyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      pincode: json['pincode'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      totalUnits: (json['totalUnits'] as num).toInt(),
      occupiedUnits: (json['occupiedUnits'] as num).toInt(),
      amenities:
          (json['amenities'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$SocietyModelToJson(SocietyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'pincode': instance.pincode,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'totalUnits': instance.totalUnits,
      'occupiedUnits': instance.occupiedUnits,
      'amenities': instance.amenities,
      'createdAt': instance.createdAt.toIso8601String(),
      'isActive': instance.isActive,
    };

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      id: json['id'] as String,
      societyId: json['societyId'] as String,
      unitNumber: json['unitNumber'] as String,
      block: json['block'] as String,
      floor: json['floor'] as String,
      type: $enumDecode(_$UnitTypeEnumMap, json['type']),
      area: (json['area'] as num).toDouble(),
      bedrooms: (json['bedrooms'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      isOccupied: json['isOccupied'] as bool,
      currentResidentId: json['currentResidentId'] as String?,
      monthlyMaintenance: (json['monthlyMaintenance'] as num).toDouble(),
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
      'id': instance.id,
      'societyId': instance.societyId,
      'unitNumber': instance.unitNumber,
      'block': instance.block,
      'floor': instance.floor,
      'type': _$UnitTypeEnumMap[instance.type]!,
      'area': instance.area,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'isOccupied': instance.isOccupied,
      'currentResidentId': instance.currentResidentId,
      'monthlyMaintenance': instance.monthlyMaintenance,
    };

const _$UnitTypeEnumMap = {
  UnitType.oneBHK: '1BHK',
  UnitType.twoBHK: '2BHK',
  UnitType.threeBHK: '3BHK',
  UnitType.fourBHK: '4BHK',
  UnitType.studio: 'STUDIO',
  UnitType.penthouse: 'PENTHOUSE',
};

AllocationRequestModel _$AllocationRequestModelFromJson(
        Map<String, dynamic> json) =>
    AllocationRequestModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      societyId: json['societyId'] as String,
      unitId: json['unitId'] as String,
      status: $enumDecode(_$AllocationRequestStatusEnumMap, json['status']),
      message: json['message'] as String?,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      approvedBy: json['approvedBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
    );

Map<String, dynamic> _$AllocationRequestModelToJson(
        AllocationRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'societyId': instance.societyId,
      'unitId': instance.unitId,
      'status': _$AllocationRequestStatusEnumMap[instance.status]!,
      'message': instance.message,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'approvedBy': instance.approvedBy,
      'rejectionReason': instance.rejectionReason,
    };

const _$AllocationRequestStatusEnumMap = {
  AllocationRequestStatus.pending: 'PENDING',
  AllocationRequestStatus.approved: 'APPROVED',
  AllocationRequestStatus.rejected: 'REJECTED',
};
