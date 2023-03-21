/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:test_project/internal/helpers/text_helper.dart';
import 'package:test_project/internal/helpers/theme_helper.dart';

class ManufacturerInfoCard extends StatelessWidget {
  final String name;

  const ManufacturerInfoCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.only(
          top: 20.h,
          right: 15.w,
          left: 10.w,
          bottom: 20.h,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
      ).copyWith(elevation: MaterialStateProperty.all(0.0)),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            name,
            style: TextHelper.medium14.copyWith(
              color: ThemeHelper.black,
            ),
          ),
        ],
      ),
    );
  }
}
