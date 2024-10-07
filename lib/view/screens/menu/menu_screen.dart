import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rubizcode_task/helper/route_helper.dart';
import 'package:rubizcode_task/view/base/bottom_menu.dart';
import 'package:rubizcode_task/view/screens/menu/inner_widget/slider_with_item.dart';

import '../../../controller/menu_cat_controller.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  final MenuCatController _menuController = Get.put(MenuCatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(1),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 36.h,
            ),
            Image.asset("assets/images/daily_topper.png"),
            SizedBox(
              height: 36.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMenuItem('assets/icons/trending_up.svg', 'Trending'),
                  _buildMenuItem('assets/icons/star.svg', 'Top 10 Today'),
                  _buildMenuItem('assets/icons/bookmark.svg', 'Archived News'),
                  _buildMenuItem(
                      'assets/icons/border_color.svg', 'Marked News'),
                ],
              ),
            ),
            SizedBox(
              height: 28.h,
            ),

            /// <-----------------  Category --------------->
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.categoryScreen);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: const Row(
                  children: [
                    Text('Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xff737373))),
                    Spacer(),
                    Text('view all', style: TextStyle(color: Colors.grey)),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),

            Expanded(
                child: SlidersWithItemView(
                    categoryList: _menuController.categoryList))
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 16.w),
          Text(title, style: TextStyle(fontSize: 16.sp)),
        ],
      ),
    );
  }
}
