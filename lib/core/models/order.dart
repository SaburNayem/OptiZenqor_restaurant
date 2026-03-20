class OrderStatusStep {
  const OrderStatusStep({
    required this.label,
    required this.isCompleted,
    required this.isCurrent,
  });

  final String label;
  final bool isCompleted;
  final bool isCurrent;
}

class OrderSummary {
  const OrderSummary({
    required this.id,
    required this.restaurantName,
    required this.itemNames,
    required this.total,
    required this.status,
    required this.createdAtLabel,
    required this.addressLabel,
    required this.timeline,
    required this.isActive,
  });

  final String id;
  final String restaurantName;
  final List<String> itemNames;
  final double total;
  final String status;
  final String createdAtLabel;
  final String addressLabel;
  final List<OrderStatusStep> timeline;
  final bool isActive;
}
