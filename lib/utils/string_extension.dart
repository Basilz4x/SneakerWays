class StringForamter {}

extension StringFormating on String {
  String cutStringOverFlow() {
    if (length > 32) {
      String newText = substring(0, 32);
      return "$newText...";
    }
    return this;
  }
}
