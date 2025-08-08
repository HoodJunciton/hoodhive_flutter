import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/maintenance_bill_model.dart';
import '../repositories/maintenance_repository.dart';

// Maintenance Repository Provider
final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepository();
});

// All Maintenance Bills Provider
final maintenanceBillsProvider = FutureProvider<List<MaintenanceBillModel>>((ref) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getMaintenanceBills();
});

// Pending Bills Provider
final pendingBillsProvider = FutureProvider<List<MaintenanceBillModel>>((ref) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getPendingBills();
});

// Payment History Provider
final paymentHistoryProvider = FutureProvider<List<MaintenanceBillModel>>((ref) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getPaymentHistory();
});

// Overdue Bills Provider
final overdueBillsProvider = FutureProvider<List<MaintenanceBillModel>>((ref) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getOverdueBills();
});

// Bills Summary Provider
final billsSummaryProvider = FutureProvider<BillsSummary>((ref) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getBillsSummary();
});

// Specific Bill Provider
final maintenanceBillProvider = FutureProvider.family<MaintenanceBillModel?, String>((ref, billId) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getMaintenanceBill(billId);
});

// Filtered Bills Provider
final filteredBillsProvider = FutureProvider.family<List<MaintenanceBillModel>, BillsFilter>((ref, filter) async {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return await repository.getMaintenanceBills(
    status: filter.status,
    fromDate: filter.fromDate,
    toDate: filter.toDate,
    forceRefresh: filter.forceRefresh,
  );
});

// Bills State Notifier for complex operations
final billsStateProvider = StateNotifierProvider<BillsNotifier, BillsState>((ref) {
  final repository = ref.watch(maintenanceRepositoryProvider);
  return BillsNotifier(repository);
});

class BillsNotifier extends StateNotifier<BillsState> {
  final MaintenanceRepository _repository;

  BillsNotifier(this._repository) : super(const BillsState.initial()) {
    loadBills();
  }

  Future<void> loadBills({bool forceRefresh = false}) async {
    if (!forceRefresh && state.bills.isNotEmpty) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final bills = await _repository.getMaintenanceBills(forceRefresh: forceRefresh);
      final summary = await _repository.getBillsSummary(forceRefresh: forceRefresh);
      
      state = state.copyWith(
        bills: bills,
        summary: summary,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refreshBills() async {
    await loadBills(forceRefresh: true);
  }

  void filterBills({
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final filteredBills = await _repository.getMaintenanceBills(
        status: status,
        fromDate: fromDate,
        toDate: toDate,
      );

      state = state.copyWith(
        bills: filteredBills,
        isLoading: false,
        currentFilter: BillsFilter(
          status: status,
          fromDate: fromDate,
          toDate: toDate,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearFilter() {
    loadBills();
  }
}

class BillsState {
  final List<MaintenanceBillModel> bills;
  final BillsSummary? summary;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;
  final BillsFilter? currentFilter;

  const BillsState({
    required this.bills,
    this.summary,
    required this.isLoading,
    this.error,
    this.lastUpdated,
    this.currentFilter,
  });

  const BillsState.initial()
      : bills = const [],
        summary = null,
        isLoading = false,
        error = null,
        lastUpdated = null,
        currentFilter = null;

  BillsState copyWith({
    List<MaintenanceBillModel>? bills,
    BillsSummary? summary,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
    BillsFilter? currentFilter,
  }) {
    return BillsState(
      bills: bills ?? this.bills,
      summary: summary ?? this.summary,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  // Computed properties
  List<MaintenanceBillModel> get pendingBills =>
      bills.where((bill) => bill.status == 'PENDING').toList();

  List<MaintenanceBillModel> get paidBills =>
      bills.where((bill) => bill.status == 'PAID').toList();

  List<MaintenanceBillModel> get overdueBills =>
      bills.where((bill) => 
          bill.status == 'PENDING' && 
          bill.dueDate.isBefore(DateTime.now())).toList();

  double get totalPending =>
      pendingBills.fold(0, (sum, bill) => sum + bill.amount);

  double get totalOverdue =>
      overdueBills.fold(0, (sum, bill) => sum + bill.amount);
}

class BillsFilter {
  final String? status;
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool forceRefresh;

  const BillsFilter({
    this.status,
    this.fromDate,
    this.toDate,
    this.forceRefresh = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BillsFilter &&
        other.status == status &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.forceRefresh == forceRefresh;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        forceRefresh.hashCode;
  }
}