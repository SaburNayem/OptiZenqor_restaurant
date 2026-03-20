class AppFormatters {
  static String currency(num amount) => '\$${amount.toStringAsFixed(2)}';

  static String timeRange(int minutes) {
    final end = minutes + 10;
    return '$minutes-$end min';
  }
}
