/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/text_helper.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class ManufacturerCard extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final void Function()? onTap;

  const ManufacturerCard({
    Key? key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(
          top: 10.h,
          right: 15.w,
          left: 10.w,
          bottom: 10.h,
        ),
        backgroundColor: Colors.white12,
        foregroundColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
      ).copyWith(elevation: MaterialStateProperty.all(0.0)),
      onPressed: onTap,
      child: Row(
        children: [
          Text(
            id,
            style: TextHelper.medium14.copyWith(
              color: ThemeHelper.subTitleColor,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextHelper.medium14.copyWith(
                    color: ThemeHelper.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextHelper.normal14.copyWith(
                    color: ThemeHelper.subTitleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
