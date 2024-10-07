import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rubizcode_task/helper/route_helper.dart';

class BottomMenu extends StatelessWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? theme.disabledColor : theme.disabledColor;
  }

  BottomNavigationBarItem getItem(
      String image, String title, ThemeData theme, int index) {
    return BottomNavigationBarItem(
        label: "",
        icon: SvgPicture.asset(
          image,
          height: 24.0,
          width: 24.0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem('assets/icons/home_icon.svg', 'Home', theme, 0),
      getItem('assets/icons/file_icon.svg', 'Document', theme, 1),
      getItem('assets/icons/notification_icon.svg', 'Notification', theme, 2),
      getItem('assets/icons/user-profile.svg', 'Profile', theme, 3),
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: menuIndex,
      onTap: (value) {
        switch (value) {
          case 0:
            Get.offAndToNamed(RouteHelper.homeScreen);
            break;
          case 1:
            Get.offAndToNamed(RouteHelper.menuScreen);
            break;
          case 2:
            Get.offAndToNamed(RouteHelper.homeScreen);
            break;
          case 3:
            Get.offAndToNamed(RouteHelper.homeScreen);
            break;
        }
      },
      items: menuItems,
    );
  }
}
