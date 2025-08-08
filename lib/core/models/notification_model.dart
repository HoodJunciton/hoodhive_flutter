import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class NotificationModel extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String message;
  
  @HiveField(3)
  final String type;
  
  @HiveField(4)
  final bool isRead;
  
  @HiveField(5)
  final Map<String, dynamic>? data;
  
  @HiveField(6)
  final DateTime createdAt;
  
  @HiveField(7)
  final DateTime? readAt;
  
  @HiveField(8)
  final DateTime? lastSyncAt;
  
  @HiveField(9)
  final bool isLocalOnly;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    this.data,
    required this.createdAt,
    this.readAt,
    this.lastSyncAt,
    this.isLocalOnly = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => 
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    Map<String, dynamic>? data,
    DateTime? createdAt,
    DateTime? readAt,
    DateTime? lastSyncAt,
    bool? isLocalOnly,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      readAt: readAt ?? this.readAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      isLocalOnly: isLocalOnly ?? this.isLocalOnly,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        message,
        type,
        isRead,
        data,
        createdAt,
        readAt,
        lastSyncAt,
        isLocalOnly,
      ];
}