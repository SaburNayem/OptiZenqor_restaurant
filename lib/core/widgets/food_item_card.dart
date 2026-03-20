import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/food_item.dart';
import '../utils/app_formatters.dart';

class FoodItemCard extends StatelessWidget {
  const FoodItemCard({
    required this.item,
    required this.onAdd,
    this.onTap,
    this.trailing,
    super.key,
  });

  final FoodItem item;
  final VoidCallback onAdd;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Text(
                          AppFormatters.currency(item.price),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Text('${item.rating}'),
                        Text('${item.prepTime} min'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Column(
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF9C26C), Color(0xFFE36F48)],
                      ),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  trailing ??
                      SizedBox(
                        width: 92,
                        child: ElevatedButton(
                          onPressed: onAdd,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text('Add'),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
