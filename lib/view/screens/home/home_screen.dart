import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rubizcode_task/controller/home_controller.dart';
import 'package:rubizcode_task/view/base/bottom_menu.dart';
import 'inner_widget/news_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(0),
      body: Obx(
        () => GestureDetector(
          onTap: _homeController.toggleBars,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              /// <--------------  News Pages ---------------------->
              PageView.builder(
                  pageSnapping: true,
                  itemCount: _homeController.newsList.length,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (v) {
                    if (_homeController.isVisible.value) {
                      _homeController.isVisible.value = false;
                    }
                  },
                  itemBuilder: (_, index) {
                    var data = _homeController.newsList[index];
                    return NewsPage(
                        imagePath: data['image'],
                        title: data['title'],
                        content: data['content'],
                        timestamp: data['sub_title'],
                        source: data['source']);
                  }),

              /// < ----------------- Tab bar ----------------->
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                top: _homeController.isVisible.value ? 0 : -85.h,
                left: 0,
                right: 0,
                child: _tabBar(),
              ),

              /// <---------------- Share option and other ----------------->
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: _homeController.isVisible.value ? 0 : -86.h,
                left: 0,
                right: 0,
                child: Container(
                  height: 76.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: _shareAndOtherOption(),
                ),
              ),
              //// <--------------- Album Card ------------->
              AnimatedOpacity(
                opacity: !_homeController.isVisible.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _albumCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tabBar() {
    return Container(
        height: 85.h,
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 30.h),
        color: Colors.white,
        child: Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 10.w),
            child: Row(
              children: List.generate(
                  _homeController.tabList.length,
                  (index) => GestureDetector(
                        onTap: () {
                          _homeController.changeTab(index);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  _homeController.selectTab.value == index
                                      ? 15.w
                                      : 10.w,
                              vertical: 5.h),
                          color: _homeController.selectTab.value == index
                              ? Colors.black
                              : null,
                          child: Text(
                            _homeController.tabList[index],
                            style: TextStyle(
                                color: _homeController.selectTab.value == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      )),
            ),
          ),
        ));
  }

  Row _shareAndOtherOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _optionCard("Archive", Icons.bookmark_outline),
        _optionCard("Highlight", Icons.edit_sharp),
        _optionCard("Share", Icons.bookmark_outline),
      ],
    );
  }

  Column _optionCard(String title, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r)),
          child: Icon(
            icon,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 12.h, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _albumCard() {
    return Container(
      height: 76.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/album_card.png"),
            fit: BoxFit.fill),
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Paris Olympiad 2024",
                style: TextStyle(fontSize: 22.sp, color: Colors.white),
              ),
              Text(
                "Related News",
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ],
          )),
          CircleAvatar(
            backgroundColor: const Color(0xFFffffff).withOpacity(0.25),
            child: SvgPicture.asset("assets/icons/arrow_right.svg"),
          )
        ],
      ),
    );
  }
}
