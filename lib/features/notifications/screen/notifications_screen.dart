import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../controller/notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Notifications')),
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final item = controller.notifications[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 14),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  child: Icon(
                    item.type == 'order'
                        ? Icons.delivery_dining_rounded
                        : Icons.local_offer_outlined,
                  ),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(item.message),
                ),
                trailing: Text(item.time),
              ),
            );
          },
        ),
      ),
    );
  }
}
