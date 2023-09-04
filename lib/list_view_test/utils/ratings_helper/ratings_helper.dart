class RatingsHelper {
  static String titleBasedOnStars(int noOfStars) {
    switch (noOfStars) {
      case 5:
        return "Excellent";
      case 4:
        return "Very Good";
      case 3:
        return "Good";
      case 2:
        return "Poor";
      case 1:
        return "Very Poor";
      default:
        return "Unknown";
    }
  }
}
