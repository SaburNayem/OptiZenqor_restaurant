import 'package:get/get.dart';

import '../../core/services/mock_api_service.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/cart/controller/cart_controller.dart';
import '../../features/checkout/controller/checkout_controller.dart';
import '../../features/favorites/controller/favorites_controller.dart';
import '../../features/home/controller/home_controller.dart';
import '../../features/main_nav/controller/main_nav_controller.dart';
import '../../features/notifications/controller/notifications_controller.dart';
import '../../features/orders/controller/orders_controller.dart';
import '../../features/profile/controller/profile_controller.dart';
import '../../features/restaurants/controller/restaurant_controller.dart';
import '../../features/search/controller/search_controller.dart';
import '../../features/settings/controller/settings_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MockApiService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.put(MainNavController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(RestaurantController(), permanent: true);
    Get.put(SearchController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(CheckoutController(), permanent: true);
    Get.put(OrdersController(), permanent: true);
    Get.put(FavoritesController(), permanent: true);
    Get.put(NotificationsController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(SettingsController(), permanent: true);
  }
}
