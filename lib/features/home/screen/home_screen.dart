import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/food_item_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/restaurant_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../../main_nav/controller/main_nav_controller.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FavoritesController>();
    final cartController = Get.find<CartController>();
    return AppShell(
      child: RefreshIndicator(
        onRefresh: controller.loadHome,
        child: Obx(() {
          if (controller.isLoading.value) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                LoadingSkeleton(height: 160),
                SizedBox(height: 16),
                LoadingSkeleton(height: 120),
                SizedBox(height: 16),
                LoadingSkeleton(height: 220),
              ],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deliver to',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            controller.location.value,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.notifications),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed(AppRoutes.cart),
                        icon: const Icon(Icons.shopping_bag_outlined),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Obx(
                          () => CircleAvatar(
                            radius: 9,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '${cartController.cartItems.length}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppSearchField(
                controller: controller.searchController,
                readOnly: true,
                onTap: () => Get.find<MainNavController>().changeTab(1),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6E2C1B), Color(0xFFE58C54)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tonight’s best offer',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Biryani feast + BBQ sides',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.promos.firstOrNull ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(AppRoutes.restaurantList),
                      child: const Text('Order now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'Food Categories',
                subtitle: 'Explore by craving',
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 108,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return Container(
                      width: 88,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(category.icon, color: AppColors.textPrimary),
                          const SizedBox(height: 10),
                          Text(
                            category.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemCount: controller.categories.length,
                ),
              ),
              const SizedBox(height: 28),
              SectionHeader(
                title: 'Popular Restaurants',
                subtitle: 'Handpicked places people reorder from',
                actionLabel: 'See all',
                onTap: () => Get.toNamed(AppRoutes.restaurantList),
              ),
              const SizedBox(height: 14),
              ...controller.restaurants
                  .take(2)
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
                          onFavorite: () => favoritesController
                              .toggleRestaurant(restaurant.id),
                          isFavorite: favoritesController.isRestaurantFavorite(
                            restaurant.id,
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 12),
              const SectionHeader(
                title: 'Recommended Food',
                subtitle: 'Based on top-rated picks',
              ),
              const SizedBox(height: 14),
              ...controller.recommendedFoods
                  .take(3)
                  .map(
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
              const SizedBox(height: 12),
              const SectionHeader(
                title: 'Nearby Restaurants',
                subtitle: 'Quick delivery around you',
              ),
              const SizedBox(height: 14),
              ...controller.nearbyRestaurants.map(
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
          );
        }),
      ),
    );
  }
}
