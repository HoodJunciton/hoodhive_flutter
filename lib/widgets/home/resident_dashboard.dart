import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/user_model.dart';
import '../../core/providers/maintenance_provider.dart';
import '../../core/repositories/maintenance_repository.dart';
import 'dashboard_card.dart';
import 'quick_actions.dart';
import 'recent_bills.dart';

class ResidentDashboard extends ConsumerWidget {
  final UserModel user;
  
  const ResidentDashboard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final billsSummaryAsync = ref.watch(billsSummaryProvider);

    return Column(
      children: [
        // Dashboard Cards
        billsSummaryAsync.when(
          data: (summary) => _buildDashboardCards(context, summary),
          loading: () => _buildDashboardCardsLoading(),
          error: (error, _) => _buildErrorCard(context, error.toString()),
        ),
        
        const SizedBox(height: 24),
        
        // Quick Actions
        const QuickActions(),
        
        const SizedBox(height: 24),
        
        // Recent Bills
        const RecentBills(),
        
        const SizedBox(height: 24),
        
        // Society Updates
        _buildSocietyUpdates(context),
        
        const SizedBox(height: 24),
        
        // Upcoming Events
        _buildUpcomingEvents(context),
      ],
    );
  }

  Widget _buildDashboardCards(BuildContext context, BillsSummary summary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
                    Navigator.pushNamed(context, '/bills');
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
                    Navigator.pushNamed(context, '/bills?filter=overdue');
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
                    Navigator.pushNamed(context, '/payment-history');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: 'My Unit',
                  value: 'A-101', // TODO: Get from user data
                  subtitle: '2BHK • 1200 sq ft',
                  icon: Icons.home,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/unit-details');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCardsLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
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
      ),
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

  Widget _buildErrorCard(BuildContext context, String error) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
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
      ),
    );
  }

  Widget _buildSocietyUpdates(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Society Updates',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/announcements');
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.announcement,
                  color: Colors.blue[700],
                  size: 20,
                ),
              ),
              title: const Text('Water Supply Maintenance'),
              subtitle: const Text('Scheduled for tomorrow 10 AM - 2 PM'),
              trailing: Text(
                '2h ago',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/announcements');
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.celebration,
                  color: Colors.green[700],
                  size: 20,
                ),
              ),
              title: const Text('Diwali Celebration'),
              subtitle: const Text('Join us for community Diwali celebration'),
              trailing: Text(
                '1d ago',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/announcements');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Events',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/events');
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '15',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          'NOV',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Society Meeting',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Community Hall • 7:00 PM',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.people,
                              size: 14,
                              color: Colors.grey[500],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '45 attending',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/events');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Join',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}