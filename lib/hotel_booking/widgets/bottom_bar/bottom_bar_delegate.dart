import 'package:flutter/material.dart';

class BottomBarDelegate extends SliverPersistentHeaderDelegate {
  BottomBarDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(BottomBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
