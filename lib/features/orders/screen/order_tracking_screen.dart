import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/orders_controller.dart';

class OrderTrackingScreen extends GetView<OrdersController> {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments as String? ?? 'o1';
    final order = controller.byId(orderId);
    if (order == null) {
      return const Scaffold(body: Center(child: Text('Order not found')));
    }
    return AppShell(
      appBar: AppBar(title: Text('Track ${order.id.toUpperCase()}')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.restaurantName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(order.status),
                  const SizedBox(height: 12),
                  Text(order.itemNames.join(', ')),
                  const SizedBox(height: 8),
                  Text(order.addressLabel),
                  const SizedBox(height: 8),
                  Text(
                    AppFormatters.currency(order.total),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...order.timeline.map(
            (step) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: step.isCompleted
                    ? Colors.green
                    : Colors.black12,
                child: Icon(
                  step.isCompleted ? Icons.check : Icons.more_horiz,
                  color: Colors.white,
                ),
              ),
              title: Text(step.label),
              subtitle: step.isCurrent ? const Text('Current status') : null,
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(label: 'Contact restaurant', onPressed: () {}),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: () {}, child: const Text('Contact rider')),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () =>
                Get.toNamed(AppRoutes.orderDetail, arguments: order.id),
            child: const Text('View full summary'),
          ),
        ],
      ),
    );
  }
}
