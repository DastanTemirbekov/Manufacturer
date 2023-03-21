import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget? child;

  const ShimmerWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ThemeHelper.shimmerBaseColor,
      highlightColor: ThemeHelper.shimmerHighlightColor,
      child: child!,
    );
  }
}
