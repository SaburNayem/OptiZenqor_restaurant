class Restaurant {
  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.cuisines,
    required this.rating,
    required this.deliveryTime,
    required this.minimumOrder,
    required this.deliveryFee,
    required this.tags,
    required this.isOpen,
    required this.priceRange,
    required this.bannerGradient,
  });

  final String id;
  final String name;
  final String description;
  final List<String> cuisines;
  final double rating;
  final int deliveryTime;
  final double minimumOrder;
  final double deliveryFee;
  final List<String> tags;
  final bool isOpen;
  final String priceRange;
  final List<int> bannerGradient;
}
