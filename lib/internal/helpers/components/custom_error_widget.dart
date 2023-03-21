/* External dependencies */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function? onTap;

  const CustomErrorWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => onTap != null ? onTap!() : null,
        icon: Icon(
          Icons.refresh,
          size: 40.r,
        ),
      ),
    );
  }
}
