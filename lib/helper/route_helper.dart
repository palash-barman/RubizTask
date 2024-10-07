import 'package:get/get_navigation/get_navigation.dart';
import 'package:rubizcode_task/view/screens/category/category_screen.dart';
import 'package:rubizcode_task/view/screens/home/home_screen.dart';
import 'package:rubizcode_task/view/screens/menu/menu_screen.dart';

class RouteHelper {
  static String homeScreen = "/splash_screen";
  static String menuScreen = "/menu_screen";
  static String categoryScreen = "/category_screen";

  static List<GetPage> routes = [
    GetPage(
        name: homeScreen,
        page: () => HomeScreen(),
        transition: Transition.noTransition),
    GetPage(
        name: menuScreen,
        page: () => MenuScreen(),
        transition: Transition.noTransition),
    GetPage(name: categoryScreen, page: () => CategoryScreen())
  ];
}
