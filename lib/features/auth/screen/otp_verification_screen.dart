import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/primary_button.dart';
import '../controller/auth_controller.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify OTP',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the 4-digit code we just sent.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            TextField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: const InputDecoration(labelText: 'OTP code'),
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: 'Verify and continue',
              onPressed: controller.verifyOtp,
            ),
          ],
        ),
      ),
    );
  }
}
