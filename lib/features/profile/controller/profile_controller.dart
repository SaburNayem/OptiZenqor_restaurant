import 'package:get/get.dart';

import '../../../core/models/user_profile.dart';
import '../../../core/services/mock_api_service.dart';

class ProfileController extends GetxController {
  ProfileController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final profile = Rxn<UserProfile>();

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    profile.value = await _apiService.getProfile();
  }
}
