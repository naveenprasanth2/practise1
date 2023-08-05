class StringUtils {
  static String convertToSentenceCase(String inputText) {
    return inputText.substring(0, 1).toUpperCase() +
        inputText.substring(1, inputText.length).toLowerCase();
  }

  static String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "th";
    }
    switch (day % 10) {
      case 1:
        return "st";
      case 2:
        return "nd";
      case 3:
        return "rd";
      default:
        return "th";
    }
  }
}
