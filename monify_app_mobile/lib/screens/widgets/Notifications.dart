import 'package:flutter/material.dart';

class NotificationWdgt extends StatefulWidget {
  const NotificationWdgt({Key? key}) : super(key: key);

  @override
  State<NotificationWdgt> createState() => _NotificationWdgtState();
}

class _NotificationWdgtState extends State<NotificationWdgt> {
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Nuevo',
      description: 'Has',
      time: 'Hace dos horas',
      type: NotificationType.achievement,
      isRead: false,
    ),
    NotificationItem(
      title: 'Nuevo',
      description: 'Has',
      time: 'Hace dos horas',
      type: NotificationType.achievement,
      isRead: false,
    ),
    NotificationItem(
      title: 'Nuevo',
      description: 'Has',
      time: 'Hace dos horas',
      type: NotificationType.achievement,
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mark_email_read, color: Colors.white),
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return _buildNotificationCard(notifications[index]);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              color: Colors.green[600],
              size: 60,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No tienes notificaciones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Te avisaremos cuando haya oportunidades',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notificacion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: notificacion.isRead ? Colors.white : Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: notificacion.isRead
            ? Border.all(color: Colors.grey[200]!)
            : Border.all(color: Colors.green[300]!, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getNotificationColor(notificacion.type).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _getNotificationIcon(notificacion.type),
            color: _getNotificationColor(notificacion.type),
            size: 24,
          ),
        ),
        title: Text(
          notificacion.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: notificacion.isRead
                ? FontWeight.normal
                : FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notificacion.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              notificacion.time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: notificacion.isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () => _markAsRead(notificacion),
      ),
    );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return Colors.amber[600]!;
      case NotificationType.warning:
        return Colors.orange[600]!;
      case NotificationType.success:
        return Colors.green[600]!;
      case NotificationType.info:
        return Colors.blue[600]!;
      case NotificationType.alert:
        return Colors.red[600]!;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.success:
        return Icons.check_circle;
      case NotificationType.info:
        return Icons.info;
      case NotificationType.alert:
        return Icons.error;
    }
  }

  void _markAsRead(NotificationItem notificacion) {
    setState(() {
      notificacion.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notificacion in notifications) {
        notificacion.isRead = true; 
      }
    });
  }
}

enum NotificationType { achievement, warning, success, info, alert }

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}
