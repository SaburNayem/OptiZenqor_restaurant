import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final favoriteRestaurantIds = <String>{'r1', 'r3'}.obs;
  final favoriteFoodIds = <String>{'f3', 'f5'}.obs;

  bool isRestaurantFavorite(String id) => favoriteRestaurantIds.contains(id);
  bool isFoodFavorite(String id) => favoriteFoodIds.contains(id);

  void toggleRestaurant(String id) {
    favoriteRestaurantIds.contains(id)
        ? favoriteRestaurantIds.remove(id)
        : favoriteRestaurantIds.add(id);
  }

  void toggleFood(String id) {
    favoriteFoodIds.contains(id)
        ? favoriteFoodIds.remove(id)
        : favoriteFoodIds.add(id);
  }
}
