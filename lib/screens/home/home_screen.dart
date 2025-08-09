import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';
import '../../core/providers/maintenance_provider.dart';
import '../../core/repositories/maintenance_repository.dart';
import '../../widgets/home/dashboard_card.dart';
import '../../widgets/home/quick_actions.dart';
import '../../widgets/home/recent_bills.dart';
import '../../widgets/common/app_drawer.dart';
import '../../widgets/home/role_based_dashboard.dart';
import '../../widgets/home/welcome_banner.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    
    // Check if user needs onboarding
    if (user != null && (!user.isProfileComplete || !user.hasAllocation)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!user.isProfileComplete) {
          Navigator.pushReplacementNamed(context, '/profile-setup');
        } else if (!user.hasAllocation) {
          Navigator.pushReplacementNamed(context, '/society-selection');
        }
      });
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              title: Text(
                'HoodJunction',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
              ),
              IconButton(
                icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
          
          // Main Content
          SliverToBoxAdapter(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(billsSummaryProvider);
                ref.invalidate(pendingBillsProvider);
              },
              child: Column(
                children: [
                  // Welcome Banner
                  WelcomeBanner(user: user),
                  
                  // Role-based Dashboard
                  RoleBasedDashboard(user: user),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
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