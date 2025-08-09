import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/user_model.dart';
import '../../core/providers/maintenance_provider.dart';
import '../../core/repositories/maintenance_repository.dart';
import 'dashboard_card.dart';
import 'quick_actions.dart';
import 'recent_bills.dart';
import 'admin_dashboard.dart';
import 'resident_dashboard.dart';

class RoleBasedDashboard extends ConsumerWidget {
  final UserModel? user;
  
  const RoleBasedDashboard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (user == null || !user!.hasAllocation) {
      return _buildOnboardingPrompt(context);
    }

    switch (user!.role.toLowerCase()) {
      case 'admin':
        return AdminDashboard(user: user!);
      case 'resident':
      case 'tenant':
        return ResidentDashboard(user: user!);
      default:
        return ResidentDashboard(user: user!);
    }
  }

  Widget _buildOnboardingPrompt(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.home_work_outlined,
            size: 64,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome to HoodJunction!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Complete your profile setup to access all features and connect with your society.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile-setup');
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Complete Profile'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/society-selection');
            },
            child: const Text('Select Society'),
          ),
        ],
      ),
    );
  }
}