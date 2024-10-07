import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rubizcode_task/view/base/bottom_menu.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final categoryList = [
    {"name": "International", "image": "assets/images/Frame 470.png"},
    {"name": "National", "image": "assets/images/Frame 469.png"},
    {"name": "Sports", "image": "assets/images/Frame 468.png"},
    {"name": "Politics", "image": "assets/images/Frame 471.png"},
    {"name": "Finance", "image": "assets/images/Frame 472.png"},
    {"name": "Entertainment", "image": "assets/images/Frame 473.png"},
    {"name": "International", "image": "assets/images/Frame 470.png"},
    {"name": "National", "image": "assets/images/Frame 469.png"},
    {"name": "Sports", "image": "assets/images/Frame 468.png"},
    {"name": "Politics", "image": "assets/images/Frame 471.png"},
    {"name": "Finance", "image": "assets/images/Frame 472.png"},
    {"name": "Entertainment", "image": "assets/images/Frame 473.png"},
    {"name": "International", "image": "assets/images/Frame 470.png"},
    {"name": "National", "image": "assets/images/Frame 469.png"},
    {"name": "Sports", "image": "assets/images/Frame 468.png"},
    {"name": "Politics", "image": "assets/images/Frame 471.png"},
    {"name": "Finance", "image": "assets/images/Frame 472.png"},
    {"name": "Entertainment", "image": "assets/images/Frame 473.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      bottomNavigationBar: const BottomMenu(1),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
          itemCount: categoryList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(categoryList[index]['image']!)),
                const SizedBox(
                  height: 4,
                ),
                Text(categoryList[index]['name']!)
              ],
            );
          }),
    );
  }
}
