import 'package:get/get.dart';

import '../../../core/models/order.dart';
import '../../../core/services/mock_api_service.dart';

class OrdersController extends GetxController {
  OrdersController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final orders = <OrderSummary>[].obs;

  List<OrderSummary> get activeOrders =>
      orders.where((order) => order.isActive).toList();
  List<OrderSummary> get cancelledOrders => orders
      .where((order) => order.status.toLowerCase().contains('cancel'))
      .toList();
  List<OrderSummary> get pastOrders => orders
      .where(
        (order) =>
            !order.isActive && !order.status.toLowerCase().contains('cancel'),
      )
      .toList();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    orders.assignAll(await _apiService.getOrders());
  }

  OrderSummary? byId(String id) =>
      orders.firstWhereOrNull((order) => order.id == id);
}
