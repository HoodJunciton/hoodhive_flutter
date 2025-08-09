import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/user_model.dart';
import 'dashboard_card.dart';

class AdminDashboard extends ConsumerWidget {
  final UserModel user;
  
  const AdminDashboard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Admin Dashboard Cards
        _buildAdminDashboardCards(context),
        
        const SizedBox(height: 24),
        
        // Quick Admin Actions
        _buildQuickAdminActions(context),
        
        const SizedBox(height: 24),
        
        // Recent Activities
        _buildRecentActivities(context),
        
        const SizedBox(height: 24),
        
        // Pending Requests
        _buildPendingRequests(context),
      ],
    );
  }

  Widget _buildAdminDashboardCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DashboardCard(
                  title: 'Total Units',
                  value: '120',
                  subtitle: '95 occupied',
                  icon: Icons.home_work,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pushNamed(context, '/admin/units');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: 'Pending Bills',
                  value: '₹2.5L',
                  subtitle: '45 residents',
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pushNamed(context, '/admin/bills');
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
                  title: 'Requests',
                  value: '12',
                  subtitle: '8 pending',
                  icon: Icons.assignment,
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pushNamed(context, '/admin/requests');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DashboardCard(
                  title: 'Complaints',
                  value: '5',
                  subtitle: '2 unresolved',
                  icon: Icons.report_problem,
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, '/admin/complaints');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAdminActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _buildActionCard(
                context,
                'Send Notice',
                Icons.campaign,
                Colors.blue,
                () => Navigator.pushNamed(context, '/admin/send-notice'),
              ),
              _buildActionCard(
                context,
                'Generate Bills',
                Icons.receipt_long,
                Colors.green,
                () => Navigator.pushNamed(context, '/admin/generate-bills'),
              ),
              _buildActionCard(
                context,
                'Manage Users',
                Icons.people,
                Colors.purple,
                () => Navigator.pushNamed(context, '/admin/users'),
              ),
              _buildActionCard(
                context,
                'Visitor Log',
                Icons.person_pin,
                Colors.orange,
                () => Navigator.pushNamed(context, '/admin/visitors'),
              ),
              _buildActionCard(
                context,
                'Maintenance',
                Icons.build,
                Colors.teal,
                () => Navigator.pushNamed(context, '/admin/maintenance'),
              ),
              _buildActionCard(
                context,
                'Reports',
                Icons.analytics,
                Colors.indigo,
                () => Navigator.pushNamed(context, '/admin/reports'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin/activities');
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                _buildActivityTile(
                  'New resident registered',
                  'John Doe joined A-205',
                  Icons.person_add,
                  Colors.green,
                  '2h ago',
                ),
                const Divider(height: 1),
                _buildActivityTile(
                  'Maintenance bill generated',
                  'November 2024 bills created',
                  Icons.receipt,
                  Colors.blue,
                  '4h ago',
                ),
                const Divider(height: 1),
                _buildActivityTile(
                  'Complaint resolved',
                  'Water leakage in B-block fixed',
                  Icons.check_circle,
                  Colors.green,
                  '1d ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String time,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      trailing: Text(
        time,
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildPendingRequests(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Requests',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/admin/requests');
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange[100],
                    child: Icon(
                      Icons.home,
                      color: Colors.orange[700],
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Unit Allocation Request',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    'Sarah Wilson • A-301',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.check, color: Colors.green),
                        iconSize: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close, color: Colors.red),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Icon(
                      Icons.build,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Maintenance Request',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    'Mike Johnson • Plumbing issue',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.check, color: Colors.green),
                        iconSize: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close, color: Colors.red),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}