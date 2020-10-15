import 'package:abora/global/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget rectBorderWidget(BuildContext context, {double height = 90 , double width= 90, Function func, String imageURL = 'assets/trainer.jpg' }) {
  ScreenUtil.init(context, designSize: Size(640, 1134), allowFontScaling: false);
  return GestureDetector(
    onTap: func,
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      color: CustomColor.dottedBorderColor,
      dashPattern: [8, 4],
      strokeWidth: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageURL),
                  fit: BoxFit.fill
            ),
            borderRadius: BorderRadius.circular(10),
            color: CustomColor.textFieldFilledColor,
          ),
          child: Icon(Icons.cloud_upload, size: 50, color: CustomColor.dottedBorderColor),
          height: height.h,
          width: width.h,
        ),
      ),
    ),
  );
}