import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../checkout/controller/checkout_controller.dart';

class PaymentMethodsScreen extends GetView<CheckoutController> {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Payment Methods')),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...controller.paymentMethods.map(
              (method) => Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  title: Text(
                    method.label,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(method.description),
                  trailing: controller.selectedPaymentId.value == method.id
                      ? const Icon(Icons.check_circle)
                      : null,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                controller.addSamplePaymentMethod();
                Get.snackbar(
                  'Payment method added',
                  'A sample card has been added and selected.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Add payment method'),
            ),
          ],
        ),
      ),
    );
  }
}
