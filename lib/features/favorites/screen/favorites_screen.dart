import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/food_item_card.dart';
import '../../../core/widgets/restaurant_card.dart';
import '../../cart/controller/cart_controller.dart';
import '../../restaurants/controller/restaurant_controller.dart';
import '../controller/favorites_controller.dart';

class FavoritesScreen extends GetView<FavoritesController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantController = Get.find<RestaurantController>();
    final cartController = Get.find<CartController>();
    return DefaultTabController(
      length: 2,
      child: AppShell(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Favorites',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Restaurants'),
                Tab(text: 'Dishes'),
              ],
            ),
            Expanded(
              child: Obx(() {
                final restaurants = restaurantController.restaurants
                    .where((item) => controller.isRestaurantFavorite(item.id))
                    .toList();
                final foods = restaurantController.foodItems
                    .where((item) => controller.isFoodFavorite(item.id))
                    .toList();
                return TabBarView(
                  children: [
                    restaurants.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: EmptyState(
                              title: 'No favorite restaurants',
                              message: 'Save places you want to come back to.',
                              icon: Icons.store_mall_directory_outlined,
                            ),
                          )
                        : ListView(
                            padding: const EdgeInsets.all(20),
                            children: restaurants
                                .map(
                                  (restaurant) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: RestaurantCard(
                                      restaurant: restaurant,
                                      onTap: () => Get.toNamed(
                                        AppRoutes.restaurantDetail,
                                        arguments: restaurant.id,
                                      ),
                                      onFavorite: () => controller
                                          .toggleRestaurant(restaurant.id),
                                      isFavorite: true,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                    foods.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: EmptyState(
                              title: 'No favorite dishes',
                              message: 'Tap the heart on meals you love.',
                              icon: Icons.favorite_border_rounded,
                            ),
                          )
                        : ListView(
                            padding: const EdgeInsets.all(20),
                            children: foods
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: FoodItemCard(
                                      item: item,
                                      onAdd: () => cartController.addItem(item),
                                      trailing: IconButton(
                                        onPressed: () =>
                                            controller.toggleFood(item.id),
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
