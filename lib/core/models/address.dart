class Address {
  const Address({
    required this.id,
    required this.label,
    required this.addressLine,
    required this.note,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String addressLine;
  final String note;
  final bool isDefault;
}
