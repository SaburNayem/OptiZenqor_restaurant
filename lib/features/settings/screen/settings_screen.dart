import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Settings')),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            SwitchListTile(
              value: controller.isDarkMode.value,
              onChanged: controller.toggleDarkMode,
              title: const Text('Dark mode structure'),
              subtitle: const Text(
                'Theme wiring is ready for backend or local persistence.',
              ),
            ),
            SwitchListTile(
              value: controller.pushOffers.value,
              onChanged: controller.togglePushOffers,
              title: const Text('Offer notifications'),
              subtitle: const Text('Promotions, discounts, and campaigns'),
            ),
            SwitchListTile(
              value: controller.orderUpdates.value,
              onChanged: controller.toggleOrderUpdates,
              title: const Text('Order updates'),
              subtitle: const Text(
                'Preparation, dispatch, and delivery alerts',
              ),
            ),
            SwitchListTile(
              value: controller.emailReceipts.value,
              onChanged: controller.toggleEmailReceipts,
              title: const Text('Email receipts'),
              subtitle: const Text(
                'Receive invoice copies and payment confirmations',
              ),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Language'),
              subtitle: Text('English'),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('App preferences'),
              subtitle: Text(
                'Delivery defaults, saved notes, and personalization hooks',
              ),
              trailing: Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
