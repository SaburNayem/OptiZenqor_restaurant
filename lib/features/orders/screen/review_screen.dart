import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/primary_button.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double restaurantRating = 4;
  double foodRating = 5;
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Reviews & Ratings')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Rate the restaurant',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          Slider(
            value: restaurantRating,
            min: 1,
            max: 5,
            divisions: 4,
            label: restaurantRating.toString(),
            onChanged: (value) => setState(() => restaurantRating = value),
          ),
          const SizedBox(height: 12),
          Text(
            'Rate the food',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          Slider(
            value: foodRating,
            min: 1,
            max: 5,
            divisions: 4,
            label: foodRating.toString(),
            onChanged: (value) => setState(() => foodRating = value),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: reviewController,
            maxLines: 5,
            decoration: const InputDecoration(labelText: 'Write review'),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              Get.snackbar(
                'Image upload',
                'Image upload is mocked for now, but the action is wired up.',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Upload image'),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: 'Submit review',
            onPressed: () {
              Get.snackbar(
                'Review submitted',
                'Thanks for sharing your feedback.',
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
