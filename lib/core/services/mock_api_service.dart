import '../data/mock_data.dart';
import '../models/address.dart';
import '../models/category.dart';
import '../models/food_item.dart';
import '../models/notification_item.dart';
import '../models/order.dart';
import '../models/payment_method.dart';
import '../models/restaurant.dart';
import '../models/user_profile.dart';

class MockApiService {
  Future<List<FoodCategory>> getCategories() async =>
      _delay(MockData.categories);

  Future<List<Restaurant>> getRestaurants() async =>
      _delay(MockData.restaurants);

  Future<List<FoodItem>> getFoodItems() async => _delay(MockData.foods);

  Future<List<Address>> getAddresses() async => _delay(MockData.addresses);

  Future<List<PaymentMethod>> getPaymentMethods() async =>
      _delay(MockData.paymentMethods);

  Future<List<OrderSummary>> getOrders() async => _delay(MockData.orders);

  Future<List<AppNotificationItem>> getNotifications() async =>
      _delay(MockData.notifications);

  Future<UserProfile> getProfile() async => _delay(MockData.profile);

  Future<List<String>> getRecentSearches() async =>
      _delay(MockData.recentSearches);

  Future<List<String>> getTrendingSearches() async =>
      _delay(MockData.trendingSearches);

  Future<List<String>> getPromoMessages() async =>
      _delay(MockData.promoMessages);

  Future<T> _delay<T>(T data) async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    return data;
  }
}
