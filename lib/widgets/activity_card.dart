import 'package:flutter/material.dart';
import 'package:hoodhive_flutter/models/dashboard.dart';

class ActivityCard extends StatelessWidget {
  final ActivityItem activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getActivityColor(activity.type),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getActivityIcon(activity.type),
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          activity.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTime(activity.time),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(activity.status),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            activity.status,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'society':
        return Colors.blue;
      case 'user':
        return Colors.green;
      case 'maintenance':
        return Colors.orange;
      case 'payment':
        return Colors.purple;
      case 'event':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'society':
        return Icons.apartment;
      case 'user':
        return Icons.person;
      case 'maintenance':
        return Icons.build;
      case 'payment':
        return Icons.payment;
      case 'event':
        return Icons.event;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}