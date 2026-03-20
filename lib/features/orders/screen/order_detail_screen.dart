import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_shell.dart';
import '../controller/orders_controller.dart';

class OrderDetailScreen extends GetView<OrdersController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String? ?? 'o1';
    final order = controller.byId(orderId);
    if (order == null) {
      return const Scaffold(body: Center(child: Text('Order not found')));
    }
    return AppShell(
      appBar: AppBar(title: const Text('Order Details')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _line('Order ID', order.id.toUpperCase()),
                  _line('Restaurant', order.restaurantName),
                  _line('Ordered at', order.createdAtLabel),
                  _line('Delivery address', order.addressLabel),
                  const Divider(height: 28),
                  ...order.itemNames.map(
                    (item) => _line(
                      item,
                      AppFormatters.currency(
                        order.total / order.itemNames.length,
                      ),
                    ),
                  ),
                  const Divider(height: 28),
                  _line(
                    'Total paid',
                    AppFormatters.currency(order.total),
                    isBold: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () =>
                Get.toNamed(AppRoutes.reviews, arguments: order.id),
            child: const Text('Rate this order'),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value, {bool isBold = false}) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: style)),
          const SizedBox(width: 20),
          Flexible(
            child: Text(value, textAlign: TextAlign.right, style: style),
          ),
        ],
      ),
    );
  }
}
