import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile.value;
    final nameController = TextEditingController(text: profile?.name ?? '');
    final emailController = TextEditingController(text: profile?.email ?? '');
    final phoneController = TextEditingController(text: profile?.phone ?? '');
    return AppShell(
      appBar: AppBar(title: const Text('Edit Profile')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Full name'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Save changes', onPressed: () => Get.back()),
        ],
      ),
    );
  }
}
