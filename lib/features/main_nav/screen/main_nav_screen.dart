import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../favorites/screen/favorites_screen.dart';
import '../../home/screen/home_screen.dart';
import '../../orders/screen/my_orders_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../../search/screen/search_screen.dart';
import '../controller/main_nav_controller.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomeScreen(),
      SearchScreen(),
      MyOrdersScreen(),
      FavoritesScreen(),
      ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: controller.tabs
              .map(
                (tab) => NavigationDestination(
                  icon: Icon(tab.icon),
                  label: tab.label,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
