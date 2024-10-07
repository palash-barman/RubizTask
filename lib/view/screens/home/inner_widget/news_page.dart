import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class NewsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String content;
  final String timestamp;
  final String source;

  const NewsPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.source,
  });
  Future<ui.Image> _getImageSize(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    final ui.Codec codec =
        await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: _getImageSize(imagePath),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          /// <======= Calculate Image Height ======>
          double imageHeight = MediaQuery.of(context).size.width *
              (snapshot.data!.height / snapshot.data!.width);
          return Stack(
            children: [
              /// <======= Full Size Screen ======>
              SizedBox(
                height: Get.height,
                width: Get.width,
              ),

              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  /// <=======  News Image ======>
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        const Color(0xFF000000).withOpacity(0.85),
                        const Color(0xFF000000).withOpacity(0.0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ).createShader(bounds),
                    blendMode: BlendMode.multiply,
                    child: SizedBox(
                      height: imageHeight.h,
                      width: double.infinity,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  /// <=======  News Title ======>
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.h,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              /// <=======  News Content Area ======>
              Positioned(
                top: imageHeight.h - 20.h,
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.h),
                        topRight: Radius.circular(16.h)),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timestamp,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        content,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        source,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              /// <========================  card =================>
              Positioned(
                  top: imageHeight.h - 30.h,
                  right: 16.r,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFC6C6C8)),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Daily Topper",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF3C3C43)),
                    ),
                  )),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
