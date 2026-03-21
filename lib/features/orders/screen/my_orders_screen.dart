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
      length: 3,
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
                Tab(text: 'Cancelled'),
              ],
            ),
            Expanded(
              child: Obx(() {
                final activeOrders = controller.activeOrders;
                final pastOrders = controller.pastOrders;
                final cancelledOrders = controller.cancelledOrders;

                return TabBarView(
                  children: [
                    _OrdersTabContent(
                      emptyTitle: 'No active orders',
                      emptyMessage:
                          'Your live restaurant updates will appear here.',
                      emptyIcon: Icons.delivery_dining_rounded,
                      children: activeOrders
                          .map(
                            (order) => _OrderTile(
                              title: order.restaurantName,
                              subtitle: order.itemNames.join(', '),
                              trailing: order.status,
                              amount: AppFormatters.currency(order.total),
                              onTap: () => Get.toNamed(
                                AppRoutes.orderTracking,
                                arguments: order.id,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    _OrdersTabContent(
                      emptyTitle: 'No past orders',
                      emptyMessage:
                          'Completed restaurant orders and invoices will show up here.',
                      emptyIcon: Icons.receipt_long_rounded,
                      children: pastOrders
                          .map(
                            (order) => _OrderTile(
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
                                            food.restaurantId == restaurant.id,
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
                            ),
                          )
                          .toList(),
                    ),
                    _OrdersTabContent(
                      emptyTitle: 'No cancelled orders',
                      emptyMessage:
                          'Cancelled restaurant orders will appear here.',
                      emptyIcon: Icons.cancel_outlined,
                      children: cancelledOrders
                          .map(
                            (order) => _OrderTile(
                              title: order.restaurantName,
                              subtitle: order.createdAtLabel,
                              trailing: order.status,
                              amount: AppFormatters.currency(order.total),
                              onTap: () => Get.toNamed(
                                AppRoutes.orderDetail,
                                arguments: order.id,
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

class _OrdersTabContent extends StatelessWidget {
  const _OrdersTabContent({
    required this.emptyTitle,
    required this.emptyMessage,
    required this.emptyIcon,
    required this.children,
  });

  final String emptyTitle;
  final String emptyMessage;
  final IconData emptyIcon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: EmptyState(
          title: emptyTitle,
          message: emptyMessage,
          icon: emptyIcon,
        ),
      );
    }

    return ListView(padding: const EdgeInsets.all(20), children: children);
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
