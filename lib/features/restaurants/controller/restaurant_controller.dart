import 'package:get/get.dart';

import '../../../core/models/food_item.dart';
import '../../../core/models/restaurant.dart';
import '../../../core/services/mock_api_service.dart';
import '../model/restaurant_filter.dart';

class RestaurantController extends GetxController {
  RestaurantController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final isLoading = true.obs;
  final restaurants = <Restaurant>[].obs;
  final foodItems = <FoodItem>[].obs;
  final filter = const RestaurantFilter().obs;
  final selectedCategoryTab = 'All'.obs;

  List<Restaurant> get filteredRestaurants {
    var list = restaurants.toList();
    final currentFilter = filter.value;
    if (currentFilter.cuisine != 'All') {
      list = list
          .where(
            (restaurant) => restaurant.cuisines.contains(currentFilter.cuisine),
          )
          .toList();
    }
    list = list
        .where((restaurant) => restaurant.rating >= currentFilter.rating)
        .toList();
    list = list
        .where(
          (restaurant) =>
              (restaurant.nearestBranch?.distanceKm ?? double.infinity) <=
              currentFilter.maxDistanceKm,
        )
        .toList();
    if (currentFilter.priceRange != 'All') {
      list = list
          .where(
            (restaurant) => restaurant.priceRange == currentFilter.priceRange,
          )
          .toList();
    }
    switch (currentFilter.sortBy) {
      case 'Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
      case 'Nearest branch':
        list.sort(
          (a, b) => (a.nearestBranch?.distanceKm ?? double.infinity).compareTo(
            b.nearestBranch?.distanceKm ?? double.infinity,
          ),
        );
      default:
        break;
    }
    return list;
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    restaurants.assignAll(await _apiService.getRestaurants());
    foodItems.assignAll(await _apiService.getFoodItems());
    isLoading.value = false;
  }

  List<String> menuTabsForRestaurant(String restaurantId) {
    final categories = foodItems
        .where((item) => item.restaurantId == restaurantId)
        .map((item) => item.category)
        .toSet()
        .toList();
    return ['All', ...categories];
  }

  List<FoodItem> menuForRestaurant(String restaurantId) {
    return foodItems.where((item) {
      final matchesRestaurant = item.restaurantId == restaurantId;
      final matchesTab =
          selectedCategoryTab.value == 'All' ||
          item.category == selectedCategoryTab.value;
      return matchesRestaurant && matchesTab;
    }).toList();
  }

  List<FoodItem> similarItems(String restaurantId, String category) {
    return foodItems
        .where(
          (item) =>
              item.restaurantId != restaurantId && item.category == category,
        )
        .take(3)
        .toList();
  }

  Restaurant? restaurantById(String id) {
    return restaurants.firstWhereOrNull((restaurant) => restaurant.id == id);
  }

  void updateFilter(RestaurantFilter nextFilter) {
    filter.value = nextFilter;
  }

  void setCategoryTab(String value) {
    selectedCategoryTab.value = value;
  }
}
