import 'package:flutter/rendering.dart';

class ResponsiveGridDelegate extends SliverGridDelegate {
  final int crossAxisCount;
  final int mainAxisSpacing;
  final int crossAxisSpacing;
  final double topAspectRatio;
  final double bottomHeight;

  const ResponsiveGridDelegate({
    required this.crossAxisCount,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.topAspectRatio,
    required this.bottomHeight
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // 计算可用宽度
    double availableWidth = constraints.crossAxisExtent;

    // 计算实际item宽度
    double itemWidth = (availableWidth - (crossAxisCount - 1) * crossAxisSpacing) / crossAxisCount;

    // 计算item高度
    double topHeight = itemWidth / topAspectRatio;
    double itemHeight = topHeight + bottomHeight;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: itemHeight + crossAxisSpacing,
      crossAxisStride: itemWidth + mainAxisSpacing,
      childMainAxisExtent: itemHeight,
      childCrossAxisExtent: itemWidth,
      reverseCrossAxis: false,
    );
  }

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) {
    if (oldDelegate is ResponsiveGridDelegate) {
        return oldDelegate.crossAxisCount != crossAxisCount ||
            oldDelegate.mainAxisSpacing != mainAxisSpacing ||
            oldDelegate.crossAxisSpacing != crossAxisSpacing ||
            oldDelegate.topAspectRatio != topAspectRatio ||
            oldDelegate.bottomHeight != bottomHeight;
    }
    return true;
  }
}