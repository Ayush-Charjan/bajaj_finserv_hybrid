import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('All notifications marked as read')),
              );
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          _buildNotificationItem(
            'EMI Due Reminder',
            'Your Personal Loan EMI of ₹16,134 is due on 15th March',
            DateTime.now().subtract(const Duration(hours: 2)),
            Icons.payment,
            Colors.red,
            true,
          ),
          _buildNotificationItem(
            'Special Offer!',
            'Get 0% interest on electronics EMI. Limited time offer!',
            DateTime.now().subtract(const Duration(hours: 5)),
            Icons.local_offer,
            Colors.orange,
            true,
          ),
          _buildNotificationItem(
            'Credit Limit Increased',
            'Congratulations! Your credit limit has been increased to ₹2,50,000',
            DateTime.now().subtract(const Duration(hours: 8)),
            Icons.trending_up,
            Colors.green,
            false,
          ),

          // Yesterday
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          _buildNotificationItem(
            'Payment Successful',
            'Your electricity bill payment of ₹1,500 was successful',
            DateTime.now().subtract(const Duration(days: 1, hours: 2)),
            Icons.check_circle,
            Colors.green,
            false,
          ),
          _buildNotificationItem(
            'New Loan Offer',
            'Pre-approved personal loan of ₹5 Lakh at 10.5% interest',
            DateTime.now().subtract(const Duration(days: 1, hours: 10)),
            Icons.account_balance,
            Colors.blue,
            false,
          ),

          // This Week
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'This Week',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          _buildNotificationItem(
            'KYC Update Required',
            'Please update your KYC documents to continue using services',
            DateTime.now().subtract(const Duration(days: 3)),
            Icons.verified_user,
            Colors.purple,
            false,
          ),
          _buildNotificationItem(
            'Reward Points Earned',
            'You earned 250 reward points on your recent purchase',
            DateTime.now().subtract(const Duration(days: 4)),
            Icons.card_giftcard,
            Colors.amber,
            false,
          ),
          _buildNotificationItem(
            'New Feature Alert',
            'Introducing Finance Manager - Track all your expenses in one place',
            DateTime.now().subtract(const Duration(days: 5)),
            Icons.new_releases,
            Colors.cyan,
            false,
          ),

          // Older
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 8),
            child: Text(
              'Older',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          _buildNotificationItem(
            'EMI Paid Successfully',
            'Your Home Loan EMI of ₹27,689 has been paid',
            DateTime.now().subtract(const Duration(days: 8)),
            Icons.check_circle_outline,
            Colors.green,
            false,
          ),
          _buildNotificationItem(
            'Document Verification Complete',
            'Your documents have been verified successfully',
            DateTime.now().subtract(const Duration(days: 10)),
            Icons.description,
            Colors.blue,
            false,
          ),
          _buildNotificationItem(
            'Festival Sale Started',
            'Enjoy exclusive discounts on EMI cards during festival sale',
            DateTime.now().subtract(const Duration(days: 12)),
            Icons.celebration,
            Colors.orange,
            false,
          ),
          _buildNotificationItem(
            'Loan Approved',
            'Your personal loan of ₹5,00,000 has been approved',
            DateTime.now().subtract(const Duration(days: 20)),
            Icons.thumb_up,
            Colors.green,
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String description,
    DateTime time,
    IconData icon,
    Color color,
    bool isUnread,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: isUnread ? 3 : 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 4),
            Text(
              _formatTime(time),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // Handle notification tap
        },
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('hh:mm a').format(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('dd MMM yyyy').format(dateTime);
    }
  }
}
