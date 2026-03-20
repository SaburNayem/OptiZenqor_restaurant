import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/main_tab.dart';

class MainNavController extends GetxController {
  final currentIndex = 0.obs;

  final tabs = const [
    MainTab(label: 'Home', icon: Icons.home_rounded),
    MainTab(label: 'Search', icon: Icons.search_rounded),
    MainTab(label: 'Orders', icon: Icons.receipt_long_rounded),
    MainTab(label: 'Favorites', icon: Icons.favorite_rounded),
    MainTab(label: 'Profile', icon: Icons.person_rounded),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
