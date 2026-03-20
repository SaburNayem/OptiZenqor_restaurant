import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/food_item_card.dart';
import '../../../core/widgets/restaurant_card.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../controller/search_controller.dart' as search_feature;

class SearchScreen extends GetView<search_feature.SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final favoritesController = Get.find<FavoritesController>();
    return AppShell(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AppSearchField(
            controller: controller.textController,
            onChanged: controller.updateQuery,
          ),
          const SizedBox(height: 20),
          Obx(() {
            if (controller.query.value.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent searches',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.recentSearches
                        .map(
                          (entry) => ActionChip(
                            label: Text(entry),
                            onPressed: () => controller.useSuggestion(entry),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Trending now',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.trendingSearches.map(
                    (entry) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(entry),
                      trailing: const Icon(Icons.north_west_rounded),
                      onTap: () => controller.useSuggestion(entry),
                    ),
                  ),
                ],
              );
            }

            if (controller.matchingFoods.isEmpty &&
                controller.matchingRestaurants.isEmpty) {
              return const EmptyState(
                title: 'No matching results',
                message: 'Try another keyword, cuisine, or restaurant name.',
                icon: Icons.search_off_rounded,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.matchingRestaurants.isNotEmpty) ...[
                  Text(
                    'Restaurants',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.matchingRestaurants.map(
                    (restaurant) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: RestaurantCard(
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
                ],
                if (controller.matchingFoods.isNotEmpty) ...[
                  Text(
                    'Dishes',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...controller.matchingFoods.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: FoodItemCard(
                        item: item,
                        onAdd: () => cartController.addItem(item),
                        onTap: () => Get.toNamed(
                          AppRoutes.restaurantDetail,
                          arguments: item.restaurantId,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}
