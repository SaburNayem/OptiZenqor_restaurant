import 'package:get/get.dart';

import '../../../core/models/notification_item.dart';
import '../../../core/services/mock_api_service.dart';

class NotificationsController extends GetxController {
  NotificationsController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final notifications = <AppNotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    notifications.assignAll(await _apiService.getNotifications());
  }

  void deleteNotification(String id) {
    notifications.removeWhere((item) => item.id == id);
  }
}
