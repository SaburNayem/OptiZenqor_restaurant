class PaymentMethod {
  const PaymentMethod({
    required this.id,
    required this.label,
    required this.description,
    required this.type,
    this.isSelected = false,
  });

  final String id;
  final String label;
  final String description;
  final String type;
  final bool isSelected;
}
