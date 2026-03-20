import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/restaurant_card.dart';
import '../controller/restaurant_controller.dart';
import '../model/restaurant_filter.dart';
import '../../../routes/app_routes.dart';
import '../../favorites/controller/favorites_controller.dart';

class RestaurantListScreen extends GetView<RestaurantController> {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FavoritesController>();
    return AppShell(
      appBar: AppBar(title: const Text('All Restaurants')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFilterSheet(context),
        label: const Text('Filters'),
        icon: const Icon(Icons.tune_rounded),
      ),
      child: RefreshIndicator(
        onRefresh: controller.load,
        child: Obx(() {
          if (controller.isLoading.value) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                LoadingSkeleton(height: 220),
                SizedBox(height: 16),
                LoadingSkeleton(height: 220),
              ],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: controller.filteredRestaurants
                .map(
                  (restaurant) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Obx(
                      () => RestaurantCard(
                        restaurant: restaurant,
                        onTap: () => Get.toNamed(
                          AppRoutes.restaurantDetail,
                          arguments: restaurant.id,
                        ),
                        onFavorite: () =>
                            favoritesController.toggleRestaurant(restaurant.id),
                        isFavorite: favoritesController.isRestaurantFavorite(
                          restaurant.id,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final current = controller.filter.value;
    String cuisine = current.cuisine;
    String sortBy = current.sortBy;
    String priceRange = current.priceRange;
    double rating = current.rating;
    double deliveryTime = current.deliveryTime.toDouble();

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) => Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Refine restaurants',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<String>(
                  initialValue: cuisine,
                  items:
                      [
                            'All',
                            'Biryani',
                            'Pizza',
                            'Healthy food',
                            'Chinese',
                            'Thai',
                          ]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                  onChanged: (value) =>
                      setState(() => cuisine = value ?? 'All'),
                  decoration: const InputDecoration(labelText: 'Cuisine'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: sortBy,
                  items: ['Recommended', 'Rating', 'Delivery time']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => sortBy = value ?? 'Recommended'),
                  decoration: const InputDecoration(labelText: 'Sort by'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: priceRange,
                  items: ['All', '\$', '\$\$', '\$\$\$']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => priceRange = value ?? 'All'),
                  decoration: const InputDecoration(labelText: 'Price range'),
                ),
                const SizedBox(height: 16),
                Text('Minimum rating: ${rating.toStringAsFixed(1)}'),
                Slider(
                  value: rating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  onChanged: (value) => setState(() => rating = value),
                ),
                const SizedBox(height: 8),
                Text('Delivery under ${deliveryTime.toInt()} min'),
                Slider(
                  value: deliveryTime,
                  min: 15,
                  max: 60,
                  divisions: 9,
                  onChanged: (value) => setState(() => deliveryTime = value),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateFilter(
                        RestaurantFilter(
                          cuisine: cuisine,
                          rating: rating,
                          deliveryTime: deliveryTime.toInt(),
                          priceRange: priceRange,
                          sortBy: sortBy,
                        ),
                      );
                      Get.back();
                    },
                    child: const Text('Apply filters'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
