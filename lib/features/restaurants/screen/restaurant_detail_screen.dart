import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/models/food_item.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/branch_map_card.dart';
import '../../../core/widgets/food_item_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../cart/controller/cart_controller.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../controller/restaurant_controller.dart';

class RestaurantDetailScreen extends GetView<RestaurantController> {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurantId = Get.arguments as String? ?? 'r1';
    final restaurant = controller.restaurantById(restaurantId);
    final cartController = Get.find<CartController>();
    final favoritesController = Get.find<FavoritesController>();

    if (restaurant == null) {
      return const Scaffold(body: Center(child: Text('Restaurant not found')));
    }

    final tabs = controller.menuTabsForRestaurant(restaurantId);
    final selectedBranchId = (restaurant.nearestBranch?.id ?? '').obs;
    if (!tabs.contains(controller.selectedCategoryTab.value)) {
      controller.setCategoryTab('All');
    }

    return AppShell(
      child: Obx(() {
        final foods = controller.menuForRestaurant(restaurantId);
        final similar = foods.isEmpty
            ? <FoodItem>[]
            : controller.similarItems(restaurantId, foods.first.category);
        final gradient = restaurant.bannerGradient.map(Color.new).toList();
        final selectedBranch = restaurant.branches.firstWhereOrNull(
          (branch) => branch.id == selectedBranchId.value,
        );
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: gradient),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: IconButton(
                        onPressed: () =>
                            favoritesController.toggleRestaurant(restaurant.id),
                        icon: Icon(
                          favoritesController.isRestaurantFavorite(
                                restaurant.id,
                              )
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          restaurant.description,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: restaurant.cuisines
                              .map(
                                (item) => Chip(
                                  label: Text(item),
                                  backgroundColor: Colors.white24,
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.84),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Stat(label: 'Rating', value: '${restaurant.rating}'),
                  _Stat(label: 'Branches', value: '${restaurant.branchCount}'),
                  _Stat(
                    label: 'Nearest',
                    value: selectedBranch == null
                        ? '--'
                        : '${selectedBranch.distanceKm.toStringAsFixed(1)} km',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Branch map',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            BranchMapCard(
              branches: restaurant.branches,
              selectedBranchId: selectedBranchId.value,
              onSelectBranch: (branch) => selectedBranchId.value = branch.id,
            ),
            if (selectedBranch != null) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedBranch.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (selectedBranch.isFlagship)
                          const Chip(label: Text('Flagship')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(selectedBranch.address),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _MiniInfo(
                          icon: Icons.near_me_rounded,
                          label:
                              '${selectedBranch.distanceKm.toStringAsFixed(1)} km away',
                        ),
                        _MiniInfo(
                          icon: Icons.schedule_rounded,
                          label: selectedBranch.openHours,
                        ),
                        _MiniInfo(
                          icon: Icons.groups_rounded,
                          label: '${selectedBranch.queueMinutes} min wait',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedBranch.features
                          .map(
                            (feature) => Chip(
                              label: Text(feature),
                              backgroundColor: AppColors.accent.withValues(
                                alpha: 0.18,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Get.snackbar(
                                'Directions ready',
                                'Map view centered on ${selectedBranch.area}.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            icon: const Icon(Icons.map_outlined),
                            label: const Text('Open map'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.snackbar(
                                'Branch selected',
                                '${selectedBranch.name} is now your active branch.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            icon: const Icon(Icons.storefront_rounded),
                            label: const Text('Choose branch'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            SizedBox(
              height: 46,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final tab = tabs[index];
                  final selected = controller.selectedCategoryTab.value == tab;
                  return ChoiceChip(
                    label: Text(tab),
                    selected: selected,
                    onSelected: (_) => controller.setCategoryTab(tab),
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : null,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            ...foods.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: FoodItemCard(
                  item: item,
                  onAdd: () => _showCustomizationSheet(item, cartController),
                  trailing: ElevatedButton(
                    onPressed: () =>
                        _showCustomizationSheet(item, cartController),
                    child: const Text('Customize'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (foods.isNotEmpty) ...[
              Text(
                'Reviews',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...foods.first.reviews.map(
                (review) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(review.userName),
                    subtitle: Text(review.comment),
                    trailing: Text('${review.rating}'),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            if (similar.isNotEmpty) ...[
              Text(
                'Similar items',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              ...similar.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FoodItemCard(
                    item: item,
                    onAdd: () => cartController.addItem(item),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Reserve or order from this branch',
              onPressed: () {
                Get.toNamed(AppRoutes.cart);
                if (selectedBranch != null) {
                  Get.snackbar(
                    'Branch linked',
                    'Menu opened for ${selectedBranch.name}.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              icon: Icons.restaurant_menu_rounded,
            ),
          ],
        );
      }),
    );
  }

  void _showCustomizationSheet(FoodItem item, CartController cartController) {
    final selected = <AddOn>[].obs;
    final noteController = TextEditingController();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(item.description),
                const SizedBox(height: 18),
                Text(
                  'Add-ons',
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ...item.addOns.map(
                  (addOn) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: selected.contains(addOn),
                    onChanged: (value) {
                      value == true
                          ? selected.add(addOn)
                          : selected.remove(addOn);
                    },
                    title: Text(addOn.name),
                    subtitle: Text('\$${addOn.price.toStringAsFixed(2)}'),
                  ),
                ),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    labelText: 'Special instructions',
                  ),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Add to cart',
                  onPressed: () {
                    cartController.addItem(
                      item,
                      addOns: selected.toList(),
                      note: noteController.text,
                    );
                    Get.back();
                  },
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

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EDE4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
