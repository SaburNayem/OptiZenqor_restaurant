import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/empty_state.dart';
import '../../cart/controller/cart_controller.dart';
import '../../restaurants/controller/restaurant_controller.dart';
import '../controller/orders_controller.dart';

class MyOrdersScreen extends GetView<OrdersController> {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final restaurantController = Get.find<RestaurantController>();
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
                  'My Orders',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Past'),
              ],
            ),
            Expanded(
              child: Obx(
                () => TabBarView(
                  children: [
                    controller.activeOrders.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: EmptyState(
                              title: 'No active orders',
                              message:
                                  'Your live delivery updates will appear here.',
                              icon: Icons.delivery_dining_rounded,
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: controller.activeOrders.length,
                            itemBuilder: (context, index) {
                              final order = controller.activeOrders[index];
                              return _OrderTile(
                                title: order.restaurantName,
                                subtitle: order.itemNames.join(', '),
                                trailing: order.status,
                                amount: AppFormatters.currency(order.total),
                                onTap: () => Get.toNamed(
                                  AppRoutes.orderTracking,
                                  arguments: order.id,
                                ),
                              );
                            },
                          ),
                    controller.pastOrders.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: EmptyState(
                              title: 'No past orders',
                              message:
                                  'Completed orders and invoices will show up here.',
                              icon: Icons.receipt_long_rounded,
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(20),
                            itemCount: controller.pastOrders.length,
                            itemBuilder: (context, index) {
                              final order = controller.pastOrders[index];
                              return _OrderTile(
                                title: order.restaurantName,
                                subtitle: order.createdAtLabel,
                                trailing: 'Reorder',
                                amount: AppFormatters.currency(order.total),
                                onTap: () {
                                  final restaurant = restaurantController
                                      .restaurants
                                      .firstWhereOrNull(
                                        (item) =>
                                            item.name == order.restaurantName,
                                      );
                                  if (restaurant != null) {
                                    final item = restaurantController.foodItems
                                        .firstWhereOrNull(
                                          (food) =>
                                              food.restaurantId ==
                                              restaurant.id,
                                        );
                                    if (item != null) {
                                      cartController.addItem(item);
                                      Get.toNamed(AppRoutes.cart);
                                    }
                                  }
                                },
                                secondaryTap: () => Get.toNamed(
                                  AppRoutes.orderDetail,
                                  arguments: order.id,
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.amount,
    required this.onTap,
    this.secondaryTap,
  });

  final String title;
  final String subtitle;
  final String trailing;
  final String amount;
  final VoidCallback onTap;
  final VoidCallback? secondaryTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text('$subtitle\n$amount'),
        ),
        isThreeLine: true,
        trailing: secondaryTap == null
            ? Text(
                trailing,
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: onTap, child: Text(trailing)),
                  TextButton(
                    onPressed: secondaryTap,
                    child: const Text('Details'),
                  ),
                ],
              ),
        onTap: onTap,
      ),
    );
  }
}
