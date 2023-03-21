import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/shimmer_widget.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class ManufacturersShimmer extends StatelessWidget {
  const ManufacturersShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 20.h,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: ThemeHelper.black,
              borderRadius: BorderRadius.circular(10.r),
            ),
            height: 50.h,
          );
        },
      ),
    );
  }
}
