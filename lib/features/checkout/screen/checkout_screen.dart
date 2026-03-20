import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = TextEditingController();
    final cartController = Get.find<CartController>();
    return AppShell(
      appBar: AppBar(title: const Text('Checkout')),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Delivery address',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...controller.addresses.map(
              (address) => _SelectableTile(
                title: address.label,
                subtitle: '${address.addressLine}\n${address.note}',
                isSelected: controller.selectedAddressId.value == address.id,
                onTap: () => controller.selectAddress(address.id),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Add new address'),
            ),
            const SizedBox(height: 20),
            Text(
              'Payment method',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...controller.paymentMethods.map(
              (method) => _SelectableTile(
                title: method.label,
                subtitle: method.description,
                isSelected: controller.selectedPaymentId.value == method.id,
                onTap: () => controller.selectPayment(method.id),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              onChanged: controller.updateNote,
              decoration: const InputDecoration(labelText: 'Delivery note'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _summaryRow(
                    'Items',
                    AppFormatters.currency(cartController.subtotal),
                  ),
                  _summaryRow(
                    'Delivery',
                    AppFormatters.currency(cartController.deliveryCharge),
                  ),
                  _summaryRow(
                    'Tax',
                    AppFormatters.currency(cartController.tax),
                  ),
                  const Divider(),
                  _summaryRow(
                    'Payable total',
                    AppFormatters.currency(cartController.total),
                    isBold: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Place order',
              onPressed: () {
                cartController.clear();
                Get.offNamed(AppRoutes.orderSuccess);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    final style = TextStyle(
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
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

class _SelectableTile extends StatelessWidget {
  const _SelectableTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        ),
      ),
    );
  }
}
