import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../models/restaurant.dart';
import '../utils/app_formatters.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    required this.restaurant,
    required this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    super.key,
  });

  final Restaurant restaurant;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final gradient = restaurant.bannerGradient.map(Color.new).toList();
    final nearestBranch = restaurant.nearestBranch;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: gradient),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 14,
                      right: 14,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.16),
                        child: IconButton(
                          onPressed: onFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      bottom: 18,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withValues(alpha: 0.16),
                        ),
                        child: Text(
                          restaurant.isOpen ? 'Open now' : 'Closed',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Text(
                restaurant.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                restaurant.description,
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
                  _InfoChip(label: '${restaurant.rating}'),
                  _InfoChip(label: '${restaurant.branchCount} branches'),
                  if (nearestBranch != null)
                    _InfoChip(
                      label: AppFormatters.distanceKm(nearestBranch.distanceKm),
                    ),
                  _InfoChip(label: restaurant.priceRange),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: restaurant.tags
                    .map(
                      (tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6EDE4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
