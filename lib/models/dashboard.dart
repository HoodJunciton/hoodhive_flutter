import 'package:equatable/equatable.dart';

// Dashboard stats
class DashboardStats extends Equatable {
  final int totalSocieties;
  final int totalResidents;
  final int totalCommittees;
  final int totalMaintenanceRequests;
  final double totalRevenue;
  final int activeUsers;
  final int pendingApprovals;
  final int upcomingEvents;
  final double monthlyGrowth;

  const DashboardStats({
    required this.totalSocieties,
    required this.totalResidents,
    required this.totalCommittees,
    required this.totalMaintenanceRequests,
    required this.totalRevenue,
    required this.activeUsers,
    required this.pendingApprovals,
    required this.upcomingEvents,
    required this.monthlyGrowth,
  });

  DashboardStats copyWith({
    int? totalSocieties,
    int? totalResidents,
    int? totalCommittees,
    int? totalMaintenanceRequests,
    double? totalRevenue,
    int? activeUsers,
    int? pendingApprovals,
    int? upcomingEvents,
    double? monthlyGrowth,
  }) {
    return DashboardStats(
      totalSocieties: totalSocieties ?? this.totalSocieties,
      totalResidents: totalResidents ?? this.totalResidents,
      totalCommittees: totalCommittees ?? this.totalCommittees,
      totalMaintenanceRequests:
          totalMaintenanceRequests ?? this.totalMaintenanceRequests,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      activeUsers: activeUsers ?? this.activeUsers,
      pendingApprovals: pendingApprovals ?? this.pendingApprovals,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      monthlyGrowth: monthlyGrowth ?? this.monthlyGrowth,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSocieties': totalSocieties,
      'totalResidents': totalResidents,
      'totalCommittees': totalCommittees,
      'totalMaintenanceRequests': totalMaintenanceRequests,
      'totalRevenue': totalRevenue,
      'activeUsers': activeUsers,
      'pendingApprovals': pendingApprovals,
      'upcomingEvents': upcomingEvents,
      'monthlyGrowth': monthlyGrowth,
    };
  }

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalSocieties: json['totalSocieties'] as int,
      totalResidents: json['totalResidents'] as int,
      totalCommittees: json['totalCommittees'] as int,
      totalMaintenanceRequests: json['totalMaintenanceRequests'] as int,
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      activeUsers: json['activeUsers'] as int,
      pendingApprovals: json['pendingApprovals'] as int,
      upcomingEvents: json['upcomingEvents'] as int,
      monthlyGrowth: (json['monthlyGrowth'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [
        totalSocieties,
        totalResidents,
        totalCommittees,
        totalMaintenanceRequests,
        totalRevenue,
        activeUsers,
        pendingApprovals,
        upcomingEvents,
        monthlyGrowth,
      ];
}

// Activity item
class ActivityItem extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final String status;
  final DateTime time;
  final String? userId;
  final String? userName;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.status,
    required this.time,
    this.userId,
    this.userName,
  });

  ActivityItem copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    String? status,
    DateTime? time,
    String? userId,
    String? userName,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'status': status,
      'time': time.toIso8601String(),
      'userId': userId,
      'userName': userName,
    };
  }

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      time: DateTime.parse(json['time'] as String),
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        description,
        status,
        time,
        userId,
        userName,
      ];
}

// Dashboard data
class DashboardData extends Equatable {
  final DashboardStats stats;
  final List<ActivityItem> recentActivities;

  const DashboardData({
    required this.stats,
    required this.recentActivities,
  });

  DashboardData copyWith({
    DashboardStats? stats,
    List<ActivityItem>? recentActivities,
  }) {
    return DashboardData(
      stats: stats ?? this.stats,
      recentActivities: recentActivities ?? this.recentActivities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': stats.toJson(),
      'recentActivities': recentActivities.map((e) => e.toJson()).toList(),
    };
  }

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      recentActivities: (json['recentActivities'] as List<dynamic>)
          .map((e) => ActivityItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [stats, recentActivities];
}

// Dashboard state for Riverpod
class DashboardState extends Equatable {
  final bool isLoading;
  final DashboardStats? stats;
  final List<ActivityItem> recentActivities;
  final String? error;

  const DashboardState({
    this.isLoading = false,
    this.stats,
    this.recentActivities = const [],
    this.error,
  });

  DashboardState copyWith({
    bool? isLoading,
    DashboardStats? stats,
    List<ActivityItem>? recentActivities,
    String? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      stats: stats ?? this.stats,
      recentActivities: recentActivities ?? this.recentActivities,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, stats, recentActivities, error];
}