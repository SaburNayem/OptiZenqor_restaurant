import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/models/user_profile.dart';
import '../../../core/services/mock_api_service.dart';

class ProfileController extends GetxController {
  ProfileController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final ImagePicker _imagePicker = ImagePicker();
  final profile = Rxn<UserProfile>();
  final isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    profile.value = await _apiService.getProfile();
  }

  Future<void> pickProfileImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1200,
    );
    if (image == null || profile.value == null) {
      return;
    }

    final bytes = await image.readAsBytes();
    profile.value = profile.value!.copyWith(avatarBytes: bytes);
  }

  Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    final current = profile.value;
    if (current == null) {
      return;
    }

    isSaving.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 250));
    profile.value = current.copyWith(name: name, email: email, phone: phone);
    isSaving.value = false;
  }
}
