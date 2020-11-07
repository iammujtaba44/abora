import 'dart:io';

import 'package:abora/global/colors.dart';
import 'package:chewie/chewie.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

Widget rectBorderWidget(BuildContext context,
    {double height = 90,
    double width = 90,
    Function func,
    File file,
    String imageURL,
    bool isSingleUpload}) {
  ScreenUtil.init(context,
      designSize: Size(640, 1134), allowFontScaling: false);
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
        child: file != null
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.textFieldFilledColor,
                ),
                height: height.h,
                width: width.h,
                child: Chewie(
                  // key: PageStorageKey("https://firebasestorage.googleapis.com/v0/b/abora-42865.appspot.com/o/videos?alt=media&token=1e28571f-84ad-4f3c-b4f2-0feba4628efb"),
                  controller: ChewieController(
                      videoPlayerController: VideoPlayerController.file(file),
                      aspectRatio: isSingleUpload ? 3.2.h : 1.8.h,
                      autoInitialize: true,
                      showControls: false,
                      looping: false,
                      autoPlay: false,
                      errorBuilder: (context, errorMessage) {
                        return Center(
                            child: Text(
                          'error',
                          style: TextStyle(color: Colors.white),
                        ));
                      }),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColor.textFieldFilledColor,
                ),
                child: Icon(Icons.cloud_upload,
                    size: 50, color: CustomColor.dottedBorderColor),
                height: height.h,
                width: width.h,
              ),
      ),
    ),
  );
}
