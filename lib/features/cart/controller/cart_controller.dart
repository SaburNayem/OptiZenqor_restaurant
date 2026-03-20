import 'package:get/get.dart';

import '../../../core/models/food_item.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  final cartItems = <CartItemModel>[].obs;
  final couponCode = ''.obs;

  double get subtotal =>
      cartItems.fold<double>(0, (sum, item) => sum + item.total);
  double get deliveryCharge => cartItems.isEmpty ? 0 : 2.5;
  double get tax => subtotal * 0.08;
  double get discount =>
      couponCode.value.trim().toUpperCase() == 'SAVE10' ? subtotal * 0.1 : 0;
  double get total => subtotal + deliveryCharge + tax - discount;

  void addItem(
    FoodItem item, {
    List<AddOn> addOns = const [],
    String note = '',
  }) {
    final existing = cartItems.firstWhereOrNull(
      (cartItem) =>
          cartItem.item.id == item.id &&
          cartItem.selectedAddOns.length == addOns.length,
    );
    if (existing != null) {
      existing.quantity += 1;
      cartItems.refresh();
      return;
    }
    cartItems.add(
      CartItemModel(
        item: item,
        quantity: 1,
        selectedAddOns: addOns,
        specialInstructions: note,
      ),
    );
  }

  void updateQuantity(CartItemModel item, int change) {
    item.quantity += change;
    if (item.quantity <= 0) {
      cartItems.remove(item);
    } else {
      cartItems.refresh();
    }
  }

  void updateInstructions(CartItemModel item, String note) {
    item.specialInstructions = note;
    cartItems.refresh();
  }

  void applyCoupon(String code) {
    couponCode.value = code;
  }

  void clear() {
    cartItems.clear();
    couponCode.value = '';
  }
}
