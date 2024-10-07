import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlidersWithItemView extends StatefulWidget {
  const SlidersWithItemView({super.key, required this.categoryList});
  final List categoryList;

  @override
  State<SlidersWithItemView> createState() => _SlidersWithItemViewState();
}

class _SlidersWithItemViewState extends State<SlidersWithItemView>
    with SingleTickerProviderStateMixin {
  final PageController _imagePageController =
      PageController(viewportFraction: 0.22);
  late TabController _tabController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.categoryList.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        debugPrint("Current Tab Index: ${_tabController.index}");
        _centerImageItem(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _centerImageItem(int index) {
    _imagePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 122.h,
          child: PageView.builder(
            controller: _imagePageController,
            itemCount: widget.categoryList.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
                _tabController.animateTo(index);
              });
            },
            itemBuilder: (context, index) {
              double scale = _currentImageIndex == index ? 1.0 : 0.8;
              return GestureDetector(
                onTap: () => _centerImageItem(index),
                child: Transform.scale(
                  scale: scale,
                  child: Column(
                    children: [
                      Container(
                        width: 96.h,
                        height: 96.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                colorFilter: _currentImageIndex == index
                                    ? null
                                    : ColorFilter.mode(
                                        const Color(0xff525252).withOpacity(
                                            0.5), 
                                        BlendMode.modulate,
                                      ),
                                image: AssetImage(
                                    widget.categoryList[index]['image']),
                                fit: BoxFit.fill)),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        widget.categoryList[index]['name'],
                        style: TextStyle(
                            fontSize:
                                _currentImageIndex == index ? 12.h : 9.6.h),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(widget.categoryList.length, (tabIndex) {
              return ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Image.asset("assets/images/unsplash.png"),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                              child: Text(
                            "এফবিআই দেশটির সাবেক প্রেসিডেন্ট ডোনাল্ড ট্রাম্প",
                            style: TextStyle(fontSize: 16.sp),
                          ))
                        ],
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
