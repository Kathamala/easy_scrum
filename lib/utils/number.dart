class Number {
  static String format(int value) {
    if (value < 10) {
      return '0$value';
    }
    return '$value';
  }
}