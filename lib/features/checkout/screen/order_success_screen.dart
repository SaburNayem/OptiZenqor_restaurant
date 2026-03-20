import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                child: Icon(Icons.check_rounded, size: 44),
              ),
              const SizedBox(height: 20),
              Text(
                'Order placed successfully',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your restaurant has started processing the order. You can track every update live.',
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Track order',
                onPressed: () =>
                    Get.offNamed(AppRoutes.orderTracking, arguments: 'o1'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.mainNav),
                child: const Text('Back to home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
