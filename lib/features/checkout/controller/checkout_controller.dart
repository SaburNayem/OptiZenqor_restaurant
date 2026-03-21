import 'package:get/get.dart';

import '../../../core/models/address.dart';
import '../../../core/models/payment_method.dart';
import '../../../core/services/mock_api_service.dart';

class CheckoutController extends GetxController {
  CheckoutController({MockApiService? apiService})
    : _apiService = apiService ?? Get.find<MockApiService>();

  final MockApiService _apiService;
  final addresses = <Address>[].obs;
  final paymentMethods = <PaymentMethod>[].obs;
  final selectedAddressId = ''.obs;
  final selectedPaymentId = ''.obs;
  final deliveryNote = ''.obs;

  Address? get selectedAddress =>
      addresses.firstWhereOrNull((item) => item.id == selectedAddressId.value);
  PaymentMethod? get selectedPayment => paymentMethods.firstWhereOrNull(
    (item) => item.id == selectedPaymentId.value,
  );

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    addresses.assignAll(await _apiService.getAddresses());
    paymentMethods.assignAll(await _apiService.getPaymentMethods());
    selectedAddressId.value = addresses.first.id;
    selectedPaymentId.value = paymentMethods.first.id;
  }

  void selectAddress(String id) => selectedAddressId.value = id;

  void selectPayment(String id) => selectedPaymentId.value = id;

  void updateNote(String value) => deliveryNote.value = value;

  void addSampleAddress() {
    final count = addresses.length + 1;
    final address = Address(
      id: 'a$count',
      label: 'Address $count',
      addressLine: 'House $count, Lake View Road',
      note: 'Saved for quick checkout',
      isDefault: false,
    );
    addresses.add(address);
    selectedAddressId.value = address.id;
  }

  void addSamplePaymentMethod() {
    final count = paymentMethods.length + 1;
    final method = PaymentMethod(
      id: 'pm$count',
      label: 'Card ending ${2400 + count}',
      description: 'Visa credit card',
      type: 'card',
    );
    paymentMethods.add(method);
    selectedPaymentId.value = method.id;
  }
}
