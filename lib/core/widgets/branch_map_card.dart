import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/restaurant.dart';

class BranchMapCard extends StatelessWidget {
  const BranchMapCard({
    required this.branches,
    required this.selectedBranchId,
    required this.onSelectBranch,
    super.key,
  });

  final List<RestaurantBranch> branches;
  final String? selectedBranchId;
  final ValueChanged<RestaurantBranch> onSelectBranch;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF4E7D5), Color(0xFFE8D1BA)],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _MapGridPainter())),
            ...branches.map((branch) {
              final isSelected = branch.id == selectedBranchId;
              return Positioned(
                left: branch.mapX * (constraints.maxWidth - 80),
                top: branch.mapY * 150,
                child: GestureDetector(
                  onTap: () => onSelectBranch(branch),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          branch.area,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                    Icon(Icons.map_outlined, color: AppColors.primary),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Branch discovery map',
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
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..strokeWidth = 1;

    for (var i = 1; i < 5; i++) {
      final dy = size.height * (i / 5);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), linePaint);
    }

    for (var i = 1; i < 6; i++) {
      final dx = size.width * (i / 6);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), linePaint);
    }

    final routePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.25)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.12, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * 0.28,
        size.width * 0.56,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.62,
        size.width * 0.9,
        size.height * 0.24,
      );
    canvas.drawPath(path, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
