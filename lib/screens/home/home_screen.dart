import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/maintenance_provider.dart';
import '../../core/repositories/maintenance_repository.dart';
import '../../widgets/home/dashboard_card.dart';
import '../../widgets/home/quick_actions.dart';
import '../../widgets/home/recent_bills.dart';
import '../../widgets/common/app_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final billsSummaryAsync = ref.watch(billsSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HoodJunction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              // Force refresh data
              ref.invalidate(billsSummaryProvider);
              ref.invalidate(pendingBillsProvider);
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(billsSummaryProvider);
          ref.invalidate(pendingBillsProvider);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(user?.displayName ?? 'User'),
              
              const SizedBox(height: 24),
              
              // Dashboard Cards
              billsSummaryAsync.when(
                data: (summary) => _buildDashboardCards(summary),
                loading: () => _buildDashboardCardsLoading(),
                error: (error, _) => _buildErrorCard(error.toString()),
              ),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              const QuickActions(),
              
              const SizedBox(height: 24),
              
              // Recent Bills
              const RecentBills(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        Text(
          userName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Here\'s what\'s happening in your society',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCards(BillsSummary summary) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Pending Bills',
                value: '₹${summary.totalPending.toStringAsFixed(0)}',
                subtitle: '${summary.pendingCount} bills',
                icon: Icons.pending_actions,
                color: Colors.orange,
                onTap: () {
                  // Navigate to pending bills
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: 'Overdue',
                value: '₹${summary.totalOverdue.toStringAsFixed(0)}',
                subtitle: '${summary.overdueCount} bills',
                icon: Icons.warning,
                color: Colors.red,
                onTap: () {
                  // Navigate to overdue bills
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Paid This Year',
                value: '₹${summary.totalPaid.toStringAsFixed(0)}',
                subtitle: '${summary.paidCount} payments',
                icon: Icons.check_circle,
                color: Colors.green,
                onTap: () {
                  // Navigate to payment history
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DashboardCard(
                title: 'Society',
                value: 'Green Valley',
                subtitle: 'A-101, 2BHK',
                icon: Icons.home,
                color: Colors.blue,
                onTap: () {
                  // Navigate to society details
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashboardCardsLoading() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildLoadingCard()),
            const SizedBox(width: 16),
            Expanded(child: _buildLoadingCard()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildLoadingCard()),
            const SizedBox(width: 16),
            Expanded(child: _buildLoadingCard()),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingCard() {
    return Card(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 8),
            const Text(
              'Failed to load dashboard',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              error,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}