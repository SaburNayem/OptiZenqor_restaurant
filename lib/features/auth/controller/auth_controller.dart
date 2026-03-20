import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../model/auth_models.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController(
    text: 'ariana.noor@example.com',
  );
  final passwordController = TextEditingController(text: 'password123');
  final nameController = TextEditingController(text: 'Ariana Noor');
  final phoneController = TextEditingController(text: '+8801712345678');
  final otpController = TextEditingController(text: '1234');

  final currentOnboardingPage = 0.obs;

  final slides = const <OnboardingSlide>[
    OnboardingSlide(
      title: 'Restaurant-quality meals,',
      highlight: 'delivered your way',
      subtitle:
          'Browse premium menus, customize dishes, and keep every order just how you like it.',
    ),
    OnboardingSlide(
      title: 'Track every order,',
      highlight: 'from kitchen to doorstep',
      subtitle:
          'Live status, clear timelines, and one-tap support keep the entire delivery flow stress-free.',
    ),
    OnboardingSlide(
      title: 'Save favorites,',
      highlight: 'repeat the good stuff',
      subtitle:
          'Build your own short list of comfort meals, healthy picks, and go-to restaurants.',
    ),
  ];

  void nextOnboarding() {
    if (currentOnboardingPage.value == slides.length - 1) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      currentOnboardingPage.value++;
    }
  }

  void login() => Get.offAllNamed(AppRoutes.mainNav);

  void signup() => Get.offAllNamed(AppRoutes.otpVerification);

  void verifyOtp() => Get.offAllNamed(AppRoutes.mainNav);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
