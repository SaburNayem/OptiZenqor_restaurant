class RestaurantFilter {
  const RestaurantFilter({
    this.cuisine = 'All',
    this.rating = 0,
    this.deliveryTime = 60,
    this.priceRange = 'All',
    this.sortBy = 'Recommended',
  });

  final String cuisine;
  final double rating;
  final int deliveryTime;
  final String priceRange;
  final String sortBy;

  RestaurantFilter copyWith({
    String? cuisine,
    double? rating,
    int? deliveryTime,
    String? priceRange,
    String? sortBy,
  }) {
    return RestaurantFilter(
      cuisine: cuisine ?? this.cuisine,
      rating: rating ?? this.rating,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      priceRange: priceRange ?? this.priceRange,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
