import 'package:dio/dio.dart';
import '../models/maintenance_bill_model.dart';
import '../services/network_service.dart';
import '../services/storage_service.dart';

class MaintenanceRepository {
  // Get maintenance bills (offline-first)
  Future<List<MaintenanceBillModel>> getMaintenanceBills({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
    bool forceRefresh = false,
  }) async {
    // Always return cached data first for offline-first approach
    List<MaintenanceBillModel> cachedBills = StorageService.getMaintenanceBills();
    
    // Filter cached bills if needed
    if (status != null) {
      cachedBills = cachedBills.where((bill) => bill.status == status).toList();
    }
    
    if (fromDate != null) {
      cachedBills = cachedBills.where((bill) => 
          bill.createdAt.isAfter(fromDate) || bill.createdAt.isAtSameMomentAs(fromDate)).toList();
    }
    
    if (toDate != null) {
      cachedBills = cachedBills.where((bill) => 
          bill.createdAt.isBefore(toDate) || bill.createdAt.isAtSameMomentAs(toDate)).toList();
    }

    // Try to fetch fresh data if connected and not recently synced
    if (await NetworkService.isConnected() && 
        (forceRefresh || _shouldRefreshBills())) {
      try {
        final queryParams = <String, dynamic>{};
        if (status != null) queryParams['status'] = status;
        if (fromDate != null) queryParams['fromDate'] = fromDate.toIso8601String();
        if (toDate != null) queryParams['toDate'] = toDate.toIso8601String();

        final response = await NetworkService.get(
          '/maintenance/bills',
          queryParameters: queryParams,
        );

        if (response.statusCode == 200) {
          final billsData = response.data as List;
          final freshBills = billsData
              .map((json) => MaintenanceBillModel.fromJson(json))
              .map((bill) => MaintenanceBillModel(
                    id: bill.id,
                    amount: bill.amount,
                    dueDate: bill.dueDate,
                    status: bill.status,
                    billType: bill.billType,
                    billMonth: bill.billMonth,
                    billYear: bill.billYear,
                    paymentDate: bill.paymentDate,
                    paymentMethod: bill.paymentMethod,
                    transactionId: bill.transactionId,
                    room: bill.room,
                    society: bill.society,
                    components: bill.components,
                    notes: bill.notes,
                    createdAt: bill.createdAt,
                    lastSyncAt: DateTime.now(),
                    isLocalOnly: false,
                  ))
              .toList();

          await StorageService.saveMaintenanceBills(freshBills);
          await StorageService.setLastSyncTime('maintenance_bills', DateTime.now());
          
          return freshBills;
        }
      } catch (e) {
        // Return cached data if network request fails
      }
    }

    return cachedBills;
  }

  // Get specific maintenance bill
  Future<MaintenanceBillModel?> getMaintenanceBill(String billId) async {
    // Check cache first
    final cachedBill = StorageService.getMaintenanceBill(billId);
    
    // Try to fetch fresh data if connected
    if (await NetworkService.isConnected()) {
      try {
        final response = await NetworkService.get('/maintenance/bills/$billId');
        
        if (response.statusCode == 200) {
          final bill = MaintenanceBillModel.fromJson(response.data);
          final updatedBill = MaintenanceBillModel(
            id: bill.id,
            amount: bill.amount,
            dueDate: bill.dueDate,
            status: bill.status,
            billType: bill.billType,
            billMonth: bill.billMonth,
            billYear: bill.billYear,
            paymentDate: bill.paymentDate,
            paymentMethod: bill.paymentMethod,
            transactionId: bill.transactionId,
            room: bill.room,
            society: bill.society,
            components: bill.components,
            notes: bill.notes,
            createdAt: bill.createdAt,
            lastSyncAt: DateTime.now(),
            isLocalOnly: false,
          );
          
          await StorageService.saveMaintenanceBill(updatedBill);
          return updatedBill;
        }
      } catch (e) {
        // Return cached data if network request fails
      }
    }

    return cachedBill;
  }

  // Get payment history
  Future<List<MaintenanceBillModel>> getPaymentHistory({
    int limit = 12,
    bool forceRefresh = false,
  }) async {
    return await getMaintenanceBills(
      status: 'PAID',
      forceRefresh: forceRefresh,
    );
  }

  // Get pending bills
  Future<List<MaintenanceBillModel>> getPendingBills({
    bool forceRefresh = false,
  }) async {
    return await getMaintenanceBills(
      status: 'PENDING',
      forceRefresh: forceRefresh,
    );
  }

  // Get overdue bills
  Future<List<MaintenanceBillModel>> getOverdueBills({
    bool forceRefresh = false,
  }) async {
    final bills = await getMaintenanceBills(
      status: 'PENDING',
      forceRefresh: forceRefresh,
    );
    
    final now = DateTime.now();
    return bills.where((bill) => bill.dueDate.isBefore(now)).toList();
  }

  // Get bills summary
  Future<BillsSummary> getBillsSummary({bool forceRefresh = false}) async {
    final bills = await getMaintenanceBills(forceRefresh: forceRefresh);
    
    final pendingBills = bills.where((bill) => bill.status == 'PENDING').toList();
    final paidBills = bills.where((bill) => bill.status == 'PAID').toList();
    final overdueBills = pendingBills.where((bill) => 
        bill.dueDate.isBefore(DateTime.now())).toList();
    
    final totalPending = pendingBills.fold<double>(
        0, (sum, bill) => sum + bill.amount);
    final totalPaid = paidBills.fold<double>(
        0, (sum, bill) => sum + bill.amount);
    final totalOverdue = overdueBills.fold<double>(
        0, (sum, bill) => sum + bill.amount);

    return BillsSummary(
      totalPending: totalPending,
      totalPaid: totalPaid,
      totalOverdue: totalOverdue,
      pendingCount: pendingBills.length,
      paidCount: paidBills.length,
      overdueCount: overdueBills.length,
    );
  }

  bool _shouldRefreshBills() {
    final lastSync = StorageService.getLastSyncTime('maintenance_bills');
    if (lastSync == null) return true;
    
    final now = DateTime.now();
    final difference = now.difference(lastSync);
    return difference.inMinutes > 15; // Refresh if last sync was more than 15 minutes ago
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'];
      }
      return 'Server error: ${e.response!.statusCode}';
    } else if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Receive timeout';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection';
    } else {
      return 'Network error occurred';
    }
  }
}

class BillsSummary {
  final double totalPending;
  final double totalPaid;
  final double totalOverdue;
  final int pendingCount;
  final int paidCount;
  final int overdueCount;

  BillsSummary({
    required this.totalPending,
    required this.totalPaid,
    required this.totalOverdue,
    required this.pendingCount,
    required this.paidCount,
    required this.overdueCount,
  });
}