import 'package:app_night_street/app/modules/cart/views/cart_view.dart';
import 'package:app_night_street/app/modules/favorite/views/favorite_view.dart';
import 'package:app_night_street/app/modules/menu/views/menu_view.dart';
import 'package:app_night_street/app/routes/app_pages.dart';
import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/component/category_builder.dart';
import 'package:app_night_street/core/component/meal_item.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F4F2),
      // appBar: BaseAppBar(),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedPageIndex.value,
          children: [
            HomePage(),
            CartView(),
            FavoriteView(),
            MenuView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color(0xffEA8558),
        onTap: (int index) => controller.selectedPageIndex.value = index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/svg/menu/home.svg",
            ),
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/svg/menu/cart.svg",
            ),
            label: "سلة الشراء",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/svg/menu/heart-circle-linear.svg",
            ),
            label: "المفضلة",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "images/svg/menu/more.svg",
            ),
            label: "المزيد",
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget BaseAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      //title: const Text('HomePageView'),
      centerTitle: true,
      actions: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: SvgPicture.asset("images/svg/notification.svg"),
        ),
        SizedBox(
          width: 10,
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.asset("images/png/image_avater.png"),
      ),
    );
  }

  Widget HomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          address(),
          SizedBox(
            height: 10,
          ),
          serechBox(),
          SizedBox(
            height: 10,
          ),
          departmentBox(),
          SizedBox(
            height: 10,
          ),
          SliderImageBox(),
          SizedBox(
            height: 10,
          ),
          resrant_section(),
          SizedBox(
            height: 10,
          ),
          Text(
            'العروض اليومية',
            style: TextStyles.font14BoldBlack,
            textAlign: TextAlign.right,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              MealItem(),
              MealItem(),
              MealItem(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    'خصومات و عروض',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Spacer(),
                  Text(
                    'شاهد الكل',
                    style: TextStyles.font14BoldOrange,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 290,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    restrant_card(),
                    restrant_card(),
                    restrant_card(),
                    restrant_card(),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Image SliderImageBox() => Image.asset("images/png/slide_image.jpg");

  Column departmentBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الأقسام',
          style: TextStyles.font14BoldBlack,
          textAlign: TextAlign.right,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              boxItem(),
              boxItem(),
              boxMoreItem(
                onTap: () {
                  Get.toNamed(Routes.CATEGORIES);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding boxMoreItem({
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffF26404).withOpacity(.10),
                borderRadius: BorderRadius.circular(
                  40,
                ),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Color(0xffF26404),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("شاهد الكل"),
          ],
        ),
      ),
    );
  }

  Widget boxItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CategoryBuilder(
        name: 'مشروبات',
        imagePath: '',
        onTap: () => Get.toNamed(Routes.CATEGORY_PRODUCTS),
      ),
    );
  }
}

Widget resrant_section() {
  return Column(
    children: [
      Row(
        children: [
          Text(
            'المطاعم',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
          Spacer(),
          Text(
            'شاهد الكل',
            style: TextStyles.font14BoldOrange,
            textAlign: TextAlign.right,
          ),
        ],
      ),
      SizedBox(
        height: 16,
      ),
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  restrant_box(),
                  restrant_box(),
                  restrant_box(),
                ],
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Widget address() {
  return Row(
    children: [
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: SvgPicture.asset("images/svg/pin.svg"),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'العنوان',
            style: TextStyles.font14BoldBlack,
            textAlign: TextAlign.center,
          ),
          Text(
            'التجمع الخامس ، ش 13 عمارة 143',
            style: TextStyles.font14mediumBlack,
            textAlign: TextAlign.right,
          )
        ],
      ),
    ],
  );
}

Widget serechBox() {
  return SizedBox(
    height: 60,
    child: Row(
      children: [
        Expanded(
          child: Container(
            //width: 100,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 10,
              ),
              child: Text("ابحث عن ما تريد"),
            ),
          ),
        ),
        Container(
          width: 50,
          height: 60,
          decoration: BoxDecoration(
            color: AppColor.KOrangeColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Widget restrant_box() {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Image.asset("images/png/image_restrant.jpg"),
            SizedBox(
              height: 10,
            ),
            Text(
              'مطعم روستو',
              style: TextStyles.font12regularGray,
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '4.9',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SvgPicture.asset(
                  "images/svg/start.svg",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Card restrant_card() {
  return Card(
    child: Container(
      width: 230,
      child: Column(
        children: [
          Container(
            height: 184,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عرض وجبة الصحاب',
                  style: TextStyles.font12regularBlack,
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("images/svg/start.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '4.9',
                          style: TextStyles.font12regularBlack,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "images/svg/delivery-bike.svg",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '25 - 20',
                          style: TextStyles.font12regularBlack,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'دقيقة',
                          style: TextStyles.font12regularBlack,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '340 جنيه',
                  style: TextStyles.font12regularBlack,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
