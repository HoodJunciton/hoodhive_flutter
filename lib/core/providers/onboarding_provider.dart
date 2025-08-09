import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/society_model.dart';
import 'auth_provider.dart';

// Onboarding State
class OnboardingState {
  final bool isProfileComplete;
  final bool hasSocietySelected;
  final bool hasUnitSelected;
  final bool hasAllocationRequested;
  final SocietyModel? selectedSociety;
  final UnitModel? selectedUnit;
  final AllocationRequestModel? allocationRequest;

  const OnboardingState({
    this.isProfileComplete = false,
    this.hasSocietySelected = false,
    this.hasUnitSelected = false,
    this.hasAllocationRequested = false,
    this.selectedSociety,
    this.selectedUnit,
    this.allocationRequest,
  });

  OnboardingState copyWith({
    bool? isProfileComplete,
    bool? hasSocietySelected,
    bool? hasUnitSelected,
    bool? hasAllocationRequested,
    SocietyModel? selectedSociety,
    UnitModel? selectedUnit,
    AllocationRequestModel? allocationRequest,
  }) {
    return OnboardingState(
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      hasSocietySelected: hasSocietySelected ?? this.hasSocietySelected,
      hasUnitSelected: hasUnitSelected ?? this.hasUnitSelected,
      hasAllocationRequested: hasAllocationRequested ?? this.hasAllocationRequested,
      selectedSociety: selectedSociety ?? this.selectedSociety,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      allocationRequest: allocationRequest ?? this.allocationRequest,
    );
  }

  bool get isComplete => hasAllocationRequested;
  
  double get progress {
    int completed = 0;
    if (isProfileComplete) completed++;
    if (hasSocietySelected) completed++;
    if (hasUnitSelected) completed++;
    if (hasAllocationRequested) completed++;
    return completed / 4.0;
  }
}

// Onboarding Notifier
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void completeProfile() {
    state = state.copyWith(isProfileComplete: true);
  }

  void selectSociety(SocietyModel society) {
    state = state.copyWith(
      selectedSociety: society,
      hasSocietySelected: true,
    );
  }

  void selectUnit(UnitModel unit) {
    state = state.copyWith(
      selectedUnit: unit,
      hasUnitSelected: true,
    );
  }

  void submitAllocationRequest(AllocationRequestModel request) {
    state = state.copyWith(
      allocationRequest: request,
      hasAllocationRequested: true,
    );
  }

  void reset() {
    state = const OnboardingState();
  }
}

// Provider
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  return OnboardingNotifier();
});

// Helper providers
final onboardingProgressProvider = Provider<double>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.progress;
});

final isOnboardingCompleteProvider = Provider<bool>((ref) {
  final onboarding = ref.watch(onboardingProvider);
  return onboarding.isComplete;
});

final needsOnboardingProvider = Provider<bool>((ref) {
  final user = ref.watch(authStateProvider).user;
  if (user == null) return false;
  
  return !user.isProfileComplete || !user.hasAllocation;
});