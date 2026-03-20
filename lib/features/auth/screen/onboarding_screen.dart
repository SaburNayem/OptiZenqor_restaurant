import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/auth_controller.dart';

class OnboardingScreen extends GetView<AuthController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final slide = controller.slides[controller.currentOnboardingPage.value];
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7C2D12), Color(0xFFF59E0B)],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.ramen_dining_rounded,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Text(
                slide.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                slide.highlight,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                slide.subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: List.generate(
                  controller.slides.length,
                  (index) => Container(
                    width: index == controller.currentOnboardingPage.value
                        ? 28
                        : 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: index == controller.currentOnboardingPage.value
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label:
                    controller.currentOnboardingPage.value ==
                        controller.slides.length - 1
                    ? 'Start ordering'
                    : 'Continue',
                onPressed: controller.nextOnboarding,
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: controller.login,
                  child: const Text('Skip for now'),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        );
      }),
    );
  }
}
