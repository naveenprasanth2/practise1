import 'package:flutter/material.dart';

class SlowScrollPhysics extends ScrollPhysics {
  const SlowScrollPhysics({required ScrollPhysics parent})
      : super(parent: parent);

  @override
  SlowScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SlowScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Adjust the scroll offset to slow down the scrolling speed
    double newOffset = offset * 0.4; // You can adjust this factor as needed
    return super.applyPhysicsToUserOffset(position, newOffset);
  }
}
