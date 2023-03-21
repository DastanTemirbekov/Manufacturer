import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_project/internal/helpers/components/all_shimmers/shimmer_widget.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class ManufacturerInfoShimmer extends StatelessWidget {
  const ManufacturerInfoShimmer({Key? key}) : super(key: key);

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
            color: ThemeHelper.black,
            height: 50.h,
          );
        },
      ),
    );
  }
}
