class StringUtils {
  static String convertToSentenceCase(String inputText) {
    return inputText.substring(0, 1).toUpperCase() +
        inputText.substring(1, inputText.length).toLowerCase();
  }
}
