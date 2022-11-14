class Number {
  static String formatNumber(int value) {
    if (value < 10) {
      return '0$value';
    }
    return '$value';
  }
}