import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/category.dart';
import '../../../core/models/food_item.dart';
import '../../../core/models/restaurant.dart';
import '../../../core/services/mock_api_service.dart';

class HomeController extends GetxController {
  HomeController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final searchController = TextEditingController();
  final location = 'Dhanmondi, Dhaka'.obs;
  final isLoading = true.obs;
  final categories = <FoodCategory>[].obs;
  final restaurants = <Restaurant>[].obs;
  final foods = <FoodItem>[].obs;
  final promos = <String>[].obs;
  final recentSearches = <String>[].obs;
  final trendingSearches = <String>[].obs;
  final selectedCategory = 'All'.obs;
  final query = ''.obs;

  List<Restaurant> get nearbyRestaurants => restaurants.take(3).toList();
  List<Restaurant> get topRatedRestaurants =>
      [...restaurants]..sort((a, b) => b.rating.compareTo(a.rating));
  List<FoodItem> get popularFoods {
    final activeCategory = selectedCategory.value;
    return foods.where((item) {
      final matchesPopular = item.isPopular;
      final matchesCategory =
          activeCategory == 'All' || item.category == activeCategory;
      return matchesPopular && matchesCategory;
    }).toList();
  }

  List<FoodItem> get homeSearchFoods {
    final normalized = query.value.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const [];
    }
    return foods.where((item) {
      return item.name.toLowerCase().contains(normalized) ||
          item.category.toLowerCase().contains(normalized);
    }).toList();
  }

  List<Restaurant> get homeSearchRestaurants {
    final normalized = query.value.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const [];
    }
    return restaurants.where((restaurant) {
      return restaurant.name.toLowerCase().contains(normalized) ||
          restaurant.branches.any(
            (branch) =>
                branch.area.toLowerCase().contains(normalized) ||
                branch.name.toLowerCase().contains(normalized),
          );
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadHome();
  }

  Future<void> loadHome() async {
    isLoading.value = true;
    categories.assignAll(await _apiService.getCategories());
    restaurants.assignAll(await _apiService.getRestaurants());
    foods.assignAll(await _apiService.getFoodItems());
    promos.assignAll(await _apiService.getPromoMessages());
    recentSearches.assignAll(await _apiService.getRecentSearches());
    trendingSearches.assignAll(await _apiService.getTrendingSearches());
    isLoading.value = false;
  }

  void updateSearch(String value) {
    query.value = value;
  }

  void useSuggestion(String value) {
    searchController.text = value;
    query.value = value;
  }

  void selectCategory(String value) {
    selectedCategory.value = value;
  }
}
