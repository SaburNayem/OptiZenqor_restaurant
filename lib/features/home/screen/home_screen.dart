import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/models/food_item.dart';
import '../../../core/models/restaurant.dart';
import '../../../core/widgets/app_search_field.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/food_item_card.dart';
import '../../../core/widgets/loading_skeleton.dart';
import '../../../core/widgets/restaurant_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../routes/app_routes.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favorites/controller/favorites_controller.dart';
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
                LoadingSkeleton(height: 220),
                SizedBox(height: 16),
                LoadingSkeleton(height: 120),
                SizedBox(height: 16),
                LoadingSkeleton(height: 220),
              ],
            );
          }

          final hasQuery = controller.query.value.trim().isNotEmpty;

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
                          'OptiZenqor_restaurant',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.location.value,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.notifications),
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const _HomePromoCarousel(
                slides: [
                  _PromoSlideData(
                    eyebrow: 'Signature Dining',
                    title: 'Chef table experiences at 3 branches',
                    message:
                        'Discover flagship ambiance, premium platters, and branch-exclusive menus.',
                    colors: [Color(0xFF6E2C1B), Color(0xFFE58C54)],
                    icon: Icons.ramen_dining_rounded,
                  ),
                  _PromoSlideData(
                    eyebrow: 'Family Feast',
                    title: 'Weekend buffet and kids corner now live',
                    message:
                        'Reserve your table early and explore branch events near you.',
                    colors: [Color(0xFF0F6A5B), Color(0xFF6BC7A0)],
                    icon: Icons.local_dining_rounded,
                  ),
                  _PromoSlideData(
                    eyebrow: 'Branch Offers',
                    title: 'Live grills, coffee bar, and dessert studio',
                    message:
                        'Each location has its own special menu and branch atmosphere.',
                    colors: [Color(0xFF1E355D), Color(0xFF5AA4E8)],
                    icon: Icons.restaurant_menu_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              AppSearchField(
                controller: controller.searchController,
                onChanged: controller.updateSearch,
                hintText: 'Search food, branch, or area',
              ),
              const SizedBox(height: 14),
              if (!hasQuery && controller.trendingSearches.isNotEmpty) ...[
                Text(
                  'Suggestions',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    ...controller.trendingSearches
                        .take(4)
                        .map(
                          (entry) => ActionChip(
                            label: Text(entry),
                            onPressed: () => controller.useSuggestion(entry),
                          ),
                        ),
                    ...controller.recentSearches
                        .take(2)
                        .map(
                          (entry) => ActionChip(
                            label: Text(entry),
                            onPressed: () => controller.useSuggestion(entry),
                          ),
                        ),
                  ],
                ),
              ],
              if (hasQuery) ...[
                const SizedBox(height: 8),
                _InlineSearchResults(
                  restaurants: controller.homeSearchRestaurants,
                  foods: controller.homeSearchFoods,
                  favoritesController: favoritesController,
                  cartController: cartController,
                ),
              ] else ...[
                const SizedBox(height: 24),
                const SectionHeader(
                  title: 'Food Categories',
                  subtitle: 'Tap a category to filter popular food',
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 108,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length + 1,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final label = isAll
                          ? 'All'
                          : controller.categories[index - 1].name;
                      final icon = isAll
                          ? Icons.grid_view_rounded
                          : controller.categories[index - 1].icon;
                      final color = isAll
                          ? const Color(0xFFEEDCC9)
                          : controller.categories[index - 1].color;
                      final selected =
                          controller.selectedCategory.value == label;

                      return GestureDetector(
                        onTap: () => controller.selectCategory(label),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          width: 92,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selected ? AppColors.primary : color,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                icon,
                                color: selected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: selected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 28),
                SectionHeader(
                  title: 'Popular Food',
                  subtitle: controller.selectedCategory.value == 'All'
                      ? 'Top dishes from your restaurant branches'
                      : 'Top ${controller.selectedCategory.value} dishes',
                ),
                const SizedBox(height: 14),
                ...controller.popularFoods
                    .take(4)
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
                  title: 'OptiZenqor_restaurant',
                  subtitle: 'Mirpur 1, Mirpur 10, and all branch locations',
                ),
                const SizedBox(height: 14),
                ...controller.nearbyRestaurants.map(
                  (restaurant) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RestaurantCard(
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
                        const SizedBox(height: 8),
                        if (restaurant.nearestBranch != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              'OptiZenqor_restaurant - ${restaurant.nearestBranch!.area}',
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}

class _InlineSearchResults extends StatelessWidget {
  const _InlineSearchResults({
    required this.restaurants,
    required this.foods,
    required this.favoritesController,
    required this.cartController,
  });

  final List<Restaurant> restaurants;
  final List<FoodItem> foods;
  final FavoritesController favoritesController;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty && foods.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Text('No search results found on the home screen.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Results',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        if (restaurants.isNotEmpty) ...[
          Text(
            'Branches',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...restaurants
              .take(2)
              .map(
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
        if (foods.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            'Food',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...foods
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
        ],
      ],
    );
  }
}

class _HomePromoCarousel extends StatefulWidget {
  const _HomePromoCarousel({required this.slides});

  final List<_PromoSlideData> slides;

  @override
  State<_HomePromoCarousel> createState() => _HomePromoCarouselState();
}

class _HomePromoCarouselState extends State<_HomePromoCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.94);
    _startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || widget.slides.length < 2) {
        return;
      }
      _currentIndex = (_currentIndex + 1) % widget.slides.length;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 248,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.slides.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final slide = widget.slides[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == widget.slides.length - 1 ? 0 : 10,
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: slide.colors),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x22000000),
                        blurRadius: 18,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              slide.eyebrow,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              slide.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              slide.message,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () =>
                                    Get.toNamed(AppRoutes.restaurantList),
                                child: const Text('View Branches'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Center(
                        child: Container(
                          width: 80,
                          height: 112,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Icon(
                            slide.icon,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.slides.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isActive ? 24 : 8,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PromoSlideData {
  const _PromoSlideData({
    required this.eyebrow,
    required this.title,
    required this.message,
    required this.colors,
    required this.icon,
  });

  final String eyebrow;
  final String title;
  final String message;
  final List<Color> colors;
  final IconData icon;
}
