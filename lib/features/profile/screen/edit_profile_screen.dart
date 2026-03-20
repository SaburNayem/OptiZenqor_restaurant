import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  final controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    final profile = controller.profile.value;
    nameController = TextEditingController(text: profile?.name ?? '');
    emailController = TextEditingController(text: profile?.email ?? '');
    phoneController = TextEditingController(text: profile?.phone ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Edit Profile')),
      child: Obx(() {
        final profile = controller.profile.value;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: profile?.avatarBytes != null
                            ? MemoryImage(profile!.avatarBytes!)
                            : null,
                        child: profile?.avatarBytes == null
                            ? const Icon(Icons.person_rounded, size: 46)
                            : null,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: controller.pickProfileImage,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFCC5C2B),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: controller.pickProfileImage,
                    child: const Text('Change profile picture'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
            PrimaryButton(
              label: controller.isSaving.value ? 'Saving...' : 'Save changes',
              onPressed: controller.isSaving.value
                  ? null
                  : () async {
                      await controller.saveProfile(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        phone: phoneController.text.trim(),
                      );
                      if (context.mounted) {
                        Get.back();
                      }
                    },
            ),
          ],
        );
      }),
    );
  }
}
