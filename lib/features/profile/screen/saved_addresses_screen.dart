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
            Container(
              height: 210,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFFF2E4D4), Color(0xFFE3D1B9)],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: _AddressMapPainter()),
                  ),
                  ...controller.addresses.asMap().entries.map((entry) {
                    final index = entry.key;
                    final address = entry.value;
                    final points = [
                      const Offset(56, 124),
                      const Offset(176, 72),
                      const Offset(254, 118),
                    ];
                    final point = points[index % points.length];
                    return Positioned(
                      left: point.dx,
                      top: point.dy,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFCC5C2B),
                            size: 28,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.92),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              address.label,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.map_outlined),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Saved location map',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              onPressed: () {
                controller.addSampleAddress();
                Get.snackbar(
                  'Address added',
                  'A new sample address is now available for checkout.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text('Add new address'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1;

    for (var i = 1; i < 5; i++) {
      final dy = size.height * (i / 5);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), linePaint);
    }

    for (var i = 1; i < 5; i++) {
      final dx = size.width * (i / 5);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), linePaint);
    }

    final routePaint = Paint()
      ..color = const Color(0xFFCC5C2B).withValues(alpha: 0.25)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.14, size.height * 0.64)
      ..quadraticBezierTo(
        size.width * 0.36,
        size.height * 0.12,
        size.width * 0.54,
        size.height * 0.38,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.62,
        size.width * 0.84,
        size.height * 0.28,
      );
    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
