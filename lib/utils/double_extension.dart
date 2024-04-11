extension DoubleExtension on double {
  double doubleToIntIfWhole() {
    if (truncateToDouble() == this) {
      return toInt().toDouble();
    } else {
      return this;
    }
  }
}
