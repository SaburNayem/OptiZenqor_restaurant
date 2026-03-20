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

  List<Restaurant> get nearbyRestaurants => restaurants.take(3).toList();
  List<Restaurant> get topRatedRestaurants =>
      [...restaurants]..sort((a, b) => b.rating.compareTo(a.rating));
  List<FoodItem> get recommendedFoods =>
      foods.where((item) => item.isPopular).toList();

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
    isLoading.value = false;
  }
}
