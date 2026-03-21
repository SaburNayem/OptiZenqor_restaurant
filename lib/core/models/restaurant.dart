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
    required this.branches,
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
  final List<RestaurantBranch> branches;

  int get branchCount => branches.length;

  RestaurantBranch? get nearestBranch {
    if (branches.isEmpty) {
      return null;
    }
    final sortedBranches = [...branches]
      ..sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return sortedBranches.first;
  }
}

class RestaurantBranch {
  const RestaurantBranch({
    required this.id,
    required this.name,
    required this.area,
    required this.address,
    required this.openHours,
    required this.phone,
    required this.distanceKm,
    required this.queueMinutes,
    required this.latitude,
    required this.longitude,
    required this.mapX,
    required this.mapY,
    required this.features,
    this.isFlagship = false,
    this.isOpen = true,
  });

  final String id;
  final String name;
  final String area;
  final String address;
  final String openHours;
  final String phone;
  final double distanceKm;
  final int queueMinutes;
  final double latitude;
  final double longitude;
  final double mapX;
  final double mapY;
  final List<String> features;
  final bool isFlagship;
  final bool isOpen;
}
