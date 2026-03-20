import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/widgets/app_shell.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Obx(() {
        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFF5C2C1D), Color(0xFFCA6A33)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    child: Icon(Icons.person_rounded, size: 32),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.email,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    profile.phone,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      profile.membershipLevel,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...[
              ('Edit profile', AppRoutes.editProfile),
              ('Saved addresses', AppRoutes.addresses),
              ('Payment methods', AppRoutes.paymentMethods),
              ('Notifications', AppRoutes.notifications),
              ('Settings', AppRoutes.settings),
              ('Help & support', AppRoutes.helpSupport),
              ('Terms & privacy', AppRoutes.legal),
            ].map(
              (entry) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(entry.$1),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Get.toNamed(entry.$2),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.login),
              child: const Text('Logout'),
            ),
          ],
        );
      }),
    );
  }
}
