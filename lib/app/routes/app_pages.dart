import 'package:get/get.dart';

import '../modules/addresses/bindings/addresses_binding.dart';
import '../modules/addresses/views/addresses_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/categoryProducts/bindings/category_products_binding.dart';
import '../modules/categoryProducts/views/category_products_view.dart';
import '../modules/complete_order/bindings/complete_order_binding.dart';
import '../modules/complete_order/views/complete_order_view.dart';
import '../modules/favorite/bindings/favorite_binding.dart';
import '../modules/favorite/views/favorite_view.dart';
import '../modules/homePage/bindings/home_page_binding.dart';
import '../modules/homePage/views/home_page_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_permission/bindings/map_permission_binding.dart';
import '../modules/map_permission/views/map_permission_view.dart';
import '../modules/mealDetails/bindings/meal_details_binding.dart';
import '../modules/mealDetails/views/meal_details_view.dart';
import '../modules/menu/bindings/menu_binding.dart';
import '../modules/menu/views/menu_view.dart';
import '../modules/new_address/bindings/new_address_binding.dart';
import '../modules/new_address/views/new_address_view.dart';
import '../modules/onBoarding/bindings/on_boarding_binding.dart';
import '../modules/onBoarding/views/on_boarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.COMPLETE_ORDER;

  static final routes = [
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PERMISSION,
      page: () => const MapPermissionView(),
      binding: MapPermissionBinding(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_PRODUCTS,
      page: () => const CategoryProductsView(),
      binding: CategoryProductsBinding(),
    ),
    GetPage(
      name: _Paths.MEAL_DETAILS,
      page: () => const MealDetailsView(),
      binding: MealDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESSES,
      page: () => const AddressesView(),
      binding: AddressesBinding(),
    ),
    GetPage(
      name: _Paths.NEW_ADDRESS,
      page: () => const NewAddressView(),
      binding: NewAddressBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETE_ORDER,
      page: () => const CompleteOrderView(),
      binding: CompleteOrderBinding(),
    ),
  ];
}
