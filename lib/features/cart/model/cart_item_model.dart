import '../../../core/models/food_item.dart';

class CartItemModel {
  CartItemModel({
    required this.item,
    required this.quantity,
    required this.selectedAddOns,
    this.specialInstructions = '',
  });

  final FoodItem item;
  int quantity;
  final List<AddOn> selectedAddOns;
  String specialInstructions;

  double get total {
    final addOnsTotal = selectedAddOns.fold<double>(
      0,
      (sum, addOn) => sum + addOn.price,
    );
    return (item.price + addOnsTotal) * quantity;
  }
}
