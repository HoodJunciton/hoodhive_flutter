import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String email;
  
  @HiveField(2)
  final String phoneNumber;
  
  @HiveField(3)
  final String role;
  
  @HiveField(4)
  final String displayName;
  
  @HiveField(5)
  final String? profilePicture;
  
  @HiveField(6)
  final bool isProfileActive;
  
  @HiveField(7)
  final String? firstName;
  
  @HiveField(8)
  final String? lastName;
  
  @HiveField(9)
  final String? aadharNumber;
  
  @HiveField(10)
  final String? panNumber;
  
  @HiveField(11)
  final DateTime? lastSyncAt;
  
  @HiveField(12)
  final String? societyId;
  
  @HiveField(13)
  final String? unitId;
  
  @HiveField(14)
  final bool isProfileComplete;
  
  @HiveField(15)
  final bool hasAllocation;

  const UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.displayName,
    this.profilePicture,
    required this.isProfileActive,
    this.firstName,
    this.lastName,
    this.aadharNumber,
    this.panNumber,
    this.lastSyncAt,
    this.societyId,
    this.unitId,
    this.isProfileComplete = false,
    this.hasAllocation = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    String? role,
    String? displayName,
    String? profilePicture,
    bool? isProfileActive,
    String? firstName,
    String? lastName,
    String? aadharNumber,
    String? panNumber,
    DateTime? lastSyncAt,
    String? societyId,
    String? unitId,
    bool? isProfileComplete,
    bool? hasAllocation,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      profilePicture: profilePicture ?? this.profilePicture,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      panNumber: panNumber ?? this.panNumber,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      societyId: societyId ?? this.societyId,
      unitId: unitId ?? this.unitId,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      hasAllocation: hasAllocation ?? this.hasAllocation,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        phoneNumber,
        role,
        displayName,
        profilePicture,
        isProfileActive,
        firstName,
        lastName,
        aadharNumber,
        panNumber,
        lastSyncAt,
        societyId,
        unitId,
        isProfileComplete,
        hasAllocation,
      ];
}