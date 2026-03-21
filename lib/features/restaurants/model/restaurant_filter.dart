class RestaurantFilter {
  const RestaurantFilter({
    this.cuisine = 'All',
    this.rating = 0,
    this.maxDistanceKm = 15,
    this.priceRange = 'All',
    this.sortBy = 'Recommended',
  });

  final String cuisine;
  final double rating;
  final int maxDistanceKm;
  final String priceRange;
  final String sortBy;

  RestaurantFilter copyWith({
    String? cuisine,
    double? rating,
    int? maxDistanceKm,
    String? priceRange,
    String? sortBy,
  }) {
    return RestaurantFilter(
      cuisine: cuisine ?? this.cuisine,
      rating: rating ?? this.rating,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      priceRange: priceRange ?? this.priceRange,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}
