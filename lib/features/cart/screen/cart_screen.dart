import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/primary_button.dart';
import '../controller/cart_controller.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final couponController = TextEditingController();
    return AppShell(
      appBar: AppBar(title: const Text('Your Cart')),
      child: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: EmptyState(
              title: 'Your cart is empty',
              message:
                  'Add meals from your favorite restaurants to start checkout.',
              icon: Icons.shopping_bag_outlined,
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...controller.cartItems.map(
              (item) => Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.item.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(AppFormatters.currency(item.total)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.selectedAddOns
                                .map((addOn) => addOn.name)
                                .join(', ')
                                .isEmpty
                            ? 'No add-ons'
                            : item.selectedAddOns
                                  .map((addOn) => addOn.name)
                                  .join(', '),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () =>
                                controller.updateQuantity(item, -1),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            onPressed: () => controller.updateQuantity(item, 1),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                      TextField(
                        controller: TextEditingController(
                          text: item.specialInstructions,
                        ),
                        onChanged: (value) =>
                            controller.updateInstructions(item, value),
                        decoration: const InputDecoration(
                          labelText: 'Special instructions',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextField(
              controller: couponController,
              decoration: InputDecoration(
                labelText: 'Coupon code',
                suffixIcon: TextButton(
                  onPressed: () =>
                      controller.applyCoupon(couponController.text),
                  child: const Text('Apply'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _PriceRow(
              label: 'Subtotal',
              value: AppFormatters.currency(controller.subtotal),
            ),
            _PriceRow(
              label: 'Delivery charge',
              value: AppFormatters.currency(controller.deliveryCharge),
            ),
            _PriceRow(
              label: 'Tax',
              value: AppFormatters.currency(controller.tax),
            ),
            _PriceRow(
              label: 'Discount',
              value: '-${AppFormatters.currency(controller.discount)}',
            ),
            const Divider(height: 24),
            _PriceRow(
              label: 'Total',
              value: AppFormatters.currency(controller.total),
              isBold: true,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Continue to checkout',
              onPressed: () => Get.toNamed(AppRoutes.checkout),
            ),
          ],
        );
      }),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
      fontSize: isBold ? 18 : 14,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
