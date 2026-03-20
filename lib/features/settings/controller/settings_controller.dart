import 'package:get/get.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final pushOffers = true.obs;
  final orderUpdates = true.obs;
  final emailReceipts = false.obs;

  void toggleDarkMode(bool value) => isDarkMode.value = value;
  void togglePushOffers(bool value) => pushOffers.value = value;
  void toggleOrderUpdates(bool value) => orderUpdates.value = value;
  void toggleEmailReceipts(bool value) => emailReceipts.value = value;
}
