import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/screen/cart_screen.dart';
import '../../favorites/screen/favorites_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../orders/screen/my_orders_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../controller/main_nav_controller.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomeScreen(),
      CartScreen(),
      MyOrdersScreen(),
      FavoritesScreen(),
      ProfileScreen(),
    ];
    final cartController = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: List.generate(controller.tabs.length, (index) {
              final tab = controller.tabs[index];
              final isSelected = controller.currentIndex.value == index;
              final isCartTab = tab.label == 'Cart';

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => controller.changeTab(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.18)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedScale(
                                duration: const Duration(milliseconds: 260),
                                scale: isSelected ? 1.08 : 1,
                                child: Icon(
                                  tab.icon,
                                  color: Colors.white,
                                  size: isSelected ? 26 : 23,
                                ),
                              ),
                              if (isCartTab)
                                Positioned(
                                  right: -8,
                                  top: -8,
                                  child: Obx(() {
                                    final count =
                                        cartController.cartItems.length;
                                    if (count == 0) {
                                      return const SizedBox.shrink();
                                    }
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.accent,
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        '$count',
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.easeOutCubic,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSelected ? 12 : 11,
                              fontWeight: isSelected
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                            ),
                            child: Text(tab.label),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
