import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../checkout/controller/checkout_controller.dart';

class SavedAddressesScreen extends GetView<CheckoutController> {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Saved Addresses')),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ...controller.addresses.map(
              (address) => Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    address.label,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('${address.addressLine}\n${address.note}'),
                  trailing: address.isDefault
                      ? const Chip(label: Text('Default'))
                      : null,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Add new address'),
            ),
          ],
        ),
      ),
    );
  }
}
