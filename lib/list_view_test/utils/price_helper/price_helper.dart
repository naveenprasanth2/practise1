class PriceHelper {
  static int findPriceDiffInPercentage(
      double originalPrice, double discountedPrice) {
    return (((originalPrice - discountedPrice) / originalPrice) * 100).ceilToDouble().toInt();
  }
}
