import 'review.dart';

class AddOn {
  const AddOn({required this.id, required this.name, required this.price});

  final String id;
  final String name;
  final double price;
}

class FoodItem {
  const FoodItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.prepTime,
    required this.tags,
    required this.addOns,
    required this.reviews,
    this.isVeg = false,
    this.isPopular = false,
  });

  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final double price;
  final String category;
  final double rating;
  final int prepTime;
  final List<String> tags;
  final List<AddOn> addOns;
  final List<Review> reviews;
  final bool isVeg;
  final bool isPopular;
}
