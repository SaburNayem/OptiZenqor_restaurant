import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/food_item.dart';
import '../../../core/models/restaurant.dart';
import '../../../core/services/mock_api_service.dart';

class SearchController extends GetxController {
  SearchController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final textController = TextEditingController();
  final query = ''.obs;
  final recentSearches = <String>[].obs;
  final trendingSearches = <String>[].obs;
  final restaurants = <Restaurant>[].obs;
  final foods = <FoodItem>[].obs;

  List<Restaurant> get matchingRestaurants => restaurants
      .where(
        (restaurant) =>
            restaurant.name.toLowerCase().contains(query.value.toLowerCase()),
      )
      .toList();

  List<FoodItem> get matchingFoods => foods
      .where(
        (item) => item.name.toLowerCase().contains(query.value.toLowerCase()),
      )
      .toList();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    recentSearches.assignAll(await _apiService.getRecentSearches());
    trendingSearches.assignAll(await _apiService.getTrendingSearches());
    restaurants.assignAll(await _apiService.getRestaurants());
    foods.assignAll(await _apiService.getFoodItems());
  }

  void updateQuery(String value) {
    query.value = value;
  }

  void useSuggestion(String value) {
    textController.text = value;
    query.value = value;
  }
}
