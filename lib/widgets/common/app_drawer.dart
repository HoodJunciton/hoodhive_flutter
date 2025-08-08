import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/auth_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            accountName: Text(
              user?.displayName ?? 'User',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              user?.email ?? user?.phoneNumber ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: user?.profilePicture != null
                  ? NetworkImage(user!.profilePicture!)
                  : null,
              child: user?.profilePicture == null
                  ? Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.primary,
                    )
                  : null,
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.home,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _DrawerItem(
                  icon: Icons.receipt_long,
                  title: 'Maintenance Bills',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to bills
                  },
                ),
                _DrawerItem(
                  icon: Icons.local_parking,
                  title: 'Parking',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to parking
                  },
                ),
                _DrawerItem(
                  icon: Icons.people,
                  title: 'Committee',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to committee
                  },
                ),
                _DrawerItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to notifications
                  },
                ),
                _DrawerItem(
                  icon: Icons.home_work,
                  title: 'Society Details',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to society details
                  },
                ),
                const Divider(),
                _DrawerItem(
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to profile
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings
                  },
                ),
                _DrawerItem(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to help
                  },
                ),
              ],
            ),
          ),

          // Footer
          const Divider(),
          _DrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () async {
              Navigator.pop(context);
              await _showLogoutDialog(context, ref);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (result == true) {
      await ref.read(authStateProvider.notifier).logout();
    }
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}