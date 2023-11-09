import 'package:get/get.dart';

import '../app/modules/appointment_mangment/bindings/appointment_mangment_binding.dart';
import '../app/modules/appointment_mangment/views/appointment_mangment_view.dart';
import '../app/modules/about_doctor/bindings/about_doctor_binding.dart';
import '../app/modules/about_doctor/views/about_doctor_view.dart';
import '../app/modules/account_menu/bindings/account_menu_binding.dart';
import '../app/modules/account_menu/views/account_menu_view.dart';
import '../app/modules/address/add_address/bindings/add_new_address_binding.dart';
import '../app/modules/address/add_address/views/add_new_address_view.dart';
import '../app/modules/address/list_addresses/bindings/delivery_addresses_binding.dart';
import '../app/modules/address/list_addresses/views/delivery_addresses_view.dart';
import '../app/modules/appointment/views/payment_appointment_view.dart';
import '../app/modules/choose_doctor/bindings/choose_doctor_binding.dart';
import '../app/modules/choose_doctor/views/choose_doctor_view.dart';
import '../app/modules/clinic_info/bindings/clinic_info_binding.dart';
import '../app/modules/clinic_info/views/clinic_info_view.dart';
import '../app/modules/complaint/complaint_active_list/bindings/complaint_active_list_binding.dart';
import '../app/modules/complaint/complaint_active_list/views/complaint_active_list_view.dart';
import '../app/modules/complaint/complaint_add_new/bindings/complaint_add_new_binding.dart';
import '../app/modules/complaint/complaint_add_new/views/complaint_add_new_view.dart';
import '../app/modules/complaint/complaint_closed_list/bindings/complaint_closed_list_binding.dart';
import '../app/modules/complaint/complaint_closed_list/views/complaint_closed_list_view.dart';
import '../app/modules/complaint/complaint_manager/bindings/complaint_manager_binding.dart';
import '../app/modules/complaint/complaint_manager/views/complaint_manager_view.dart';
import '../app/modules/edit_appointment/bindings/edit_appointment_binding.dart';
import '../app/modules/edit_appointment/views/edit_appointment_view.dart';
import '../app/modules/favorite/bindings/favorite_binding.dart';
import '../app/modules/favorite/views/favorite_view.dart';
import '../app/modules/gift_cards/bindings/gift_cards_binding.dart';
import '../app/modules/gift_cards/views/gift_cards_view.dart';
import '../app/modules/google_map/bindings/google_map_binding.dart';
import '../app/modules/google_map/views/google_map_view.dart';
import '../app/modules/home_page/bindings/home_page_binding.dart';
import '../app/modules/home_page/views/home_page_view.dart';
import '../app/modules/home_page_products/bindings/home_page_products_binding.dart';
import '../app/modules/home_page_products/views/home_page_products_view.dart';
import '../app/modules/home_page_services/bindings/home_page_services_binding.dart';
import '../app/modules/home_page_services/views/home_page_services_view.dart';
import '../app/modules/layout/bindings/layout_binding.dart';
import '../app/modules/layout/views/layout_view.dart';
import '../app/modules/login/bindings/login_binding.dart';
import '../app/modules/login/views/login_view.dart';
import '../app/modules/notification/controller/notifications_controller.dart';
import '../app/modules/notification/view/notification_page.dart';
import '../app/modules/offerHome/bindings/offer_home_binding.dart';
import '../app/modules/offerHome/views/offer_home_view.dart';
import '../app/modules/offer_list/bindings/offer_list_binding.dart';
import '../app/modules/offer_list/views/offer_list_view.dart';
import '../app/modules/offer_product_filter/bindings/offer_product_filter_binding.dart';
import '../app/modules/offer_product_filter/views/offer_product_filter_view.dart';
import '../app/modules/offer_service_filter/bindings/offer_service_filter_binding.dart';
import '../app/modules/offer_service_filter/views/offer_service_filter_view.dart';
import '../app/modules/order_cancel/bindings/order_cancel_binding.dart';
import '../app/modules/order_cancel/views/order_cancel_view.dart';
import '../app/modules/order_complete/bindings/order_complete_binding.dart';
import '../app/modules/order_complete/views/order_complete_view.dart';
import '../app/modules/order_details/bindings/order_details_binding.dart';
import '../app/modules/order_details/views/order_details_delivered_view.dart';
import '../app/modules/order_details_cancelled/views/order_details_cancelled_view.dart';
import '../app/modules/order_details_underway/views/order_details_underway_view.dart';
import '../app/modules/orders_list/bindings/orders_list_binding.dart';
import '../app/modules/orders_list/views/orders_list_view.dart';
import '../app/modules/product_details/bindings/product_details_binding.dart';
import '../app/modules/product_details/views/product_details_view.dart';
import '../app/modules/product_search/bindings/product_search_binding.dart';
import '../app/modules/product_search/views/product_search_view.dart';
import '../app/modules/products_list/bindings/products_list_binding.dart';
import '../app/modules/products_list/views/products_list_view.dart';
import '../app/modules/register/bindings/register_binding.dart';
import '../app/modules/register/views/register_view.dart';
import '../app/modules/service_cancel/bindings/service_cancel_binding.dart';
import '../app/modules/service_cancel/views/service_cancel_view.dart';
import '../app/modules/service_detail/bindings/service_detail_binding.dart';
import '../app/modules/service_detail/views/service_detail_view.dart';
import '../app/modules/service_review/bindings/service_review_binding.dart';
import '../app/modules/service_review/views/service_review_view.dart';
import '../app/modules/services_reviews/bindings/services_reviews_binding.dart';
import '../app/modules/services_reviews/views/services_reviews_view.dart';
import '../app/modules/services_search/bindings/services_search_binding.dart';
import '../app/modules/services_search/views/services_search_view.dart';
import '../app/modules/shoppint_cart/bindings/shopping_cart_binding.dart';
import '../app/modules/shoppint_cart/views/shopping_cart_view.dart';
import '../app/modules/splash/splash_page.dart';
import '../app/modules/static/about_us_page.dart';
import '../app/modules/static/faq_page.dart';
import '../app/modules/static/privacy_policy_page.dart';
import '../app/modules/static/terms_psge.dart';
import '../app/modules/update_phone/bindings/update_phone_binding.dart';
import '../app/modules/update_phone/views/update_phone_otp_view.dart';
import '../app/modules/update_phone/views/update_phone_view.dart';
import '../app/modules/update_profile/view/update_profile.dart';
import '../app/modules/wallet/controller/wallet_controller.dart';
import '../app/modules/wallet/wallet_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashPage(),
    ),
    GetPage(
      name: Routes.updateProfile,
      page: () => const UpdateProfilePage(),
    ),
    GetPage(
      name: Routes.termsPage,
      page: () => TermsPage(),
    ),
    GetPage(
      name: Routes.aboutUsPage,
      page: () => AboutUsPage(),
    ),
    GetPage(
      name: Routes.privacyPolicyPage,
      page: () => PrivacyPolicyPage(),
    ),
    GetPage(
      name: Routes.faqPage,
      page: () => FaqPage(),
    ),
    GetPage(
      name: Routes.notificationPage,
      page: () => const NotificationPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NotificationController>(
          () => NotificationController(),
        );
      }),
    ),
    GetPage(
      name: Routes.walletPage,
      page: () => WalletPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<WalletController>(
            () => WalletController(),
            fenix: true,
          );
        },
      ),
    ),
    GetPage(
      name: Routes.OFFER_LIST,
      page: () => OfferListView(),
      binding: OfferListBinding(),
      children: [
        GetPage(
          name: Routes.OFFER_SERVICE_FILTER,
          page: () => const OfferServiceFilterView(),
          binding: OfferServiceFilterBinding(),
        ),
        GetPage(
          name: Routes.OFFER_PRODUCT_FILTER,
          page: () => const OfferProductFilterView(),
          binding: OfferProductFilterBinding(),
        ),
      ],
    ),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT_MENU,
      page: () => AccountMenuView(),
      binding: AccountMenuBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    // GetPage(
    //   name: Routes.VERIFY_PHONE,
    //   page: () => VerifyPhoneView(),
    //   binding: VerifyPhoneBinding(),
    // ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.GIFT_CARDS,
      page: () => GiftCardsView(),
      binding: GiftCardsBinding(),
    ),
    // GetPage(
    //   name: Routes.GIFT_CARD_PAYMENT,
    //   page: () => GiftCardPaymentView(),
    //   binding: GiftCardPaymentBinding(),
    // ),
    GetPage(
      name: Routes.COMPLAINT_ADD_NEW,
      page: () => ComplaintAddNewView(),
      binding: ComplaintAddNewBinding(),
    ),
    GetPage(
      name: Routes.OFFER_HOME,
      page: () => const OfferHomeView(),
      binding: OfferHomeBinding(),
    ),
    GetPage(
      name: Routes.COMPLAINT_ACTIVE_LIST,
      page: () => ComplaintActiveListView(),
      binding: ComplaintActiveListBinding(),
    ),
    GetPage(
      name: Routes.COMPLAINT_CLOSED_LIST,
      page: () => ComplaintClosedListView(),
      binding: ComplaintClosedListBinding(),
    ),
    GetPage(
      name: Routes.COMPLAINT_MANAGER,
      page: () => ComplaintManagerView(),
      binding: ComplaintManagerBinding(),
    ),
    // GetPage(
    //   name: Routes.COMPLAINT_DETAILS,
    //   page: () => ComplaintDetailsView(),
    //   binding: ComplaintDetailsBinding(),
    // ),
    GetPage(
      name: Routes.HOME_PAGE_PRODUCTS,
      page: () => HomePageProductsView(),
      binding: HomePageProductsBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS_LIST,
      page: () => ProductsListView(),
      binding: ProductsListBinding(),
    ),
    GetPage(
      name: Routes.LAYOUT,
      page: () => LayoutView(),
      binding: LayoutBinding(),
    ),
    GetPage(
      name: Routes.HOME_PAGE_SERVICES,
      page: () => HomePageServicesView(),
      binding: HomePageServicesBinding(),
    ),
    GetPage(
      name: Routes.FAVORITE,
      page: () => FavoriteView(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.CLINIC_INFO,
      page: () => const ClinicInfoView(),
      binding: ClinicInfoBinding(),
    ),

    GetPage(
      name: Routes.PRODUCT_SEARCH,
      page: () => ProductSearchView(),
      binding: ProductSearchBinding(),
    ),
    GetPage(
      name: Routes.SERVICES_SEARCH,
      page: () => ServicesSearchView(),
      binding: ServicesSearchBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_DETAIL,
      page: () => ServiceDetailView(),
      binding: ServiceDetailBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: Routes.ABOUT_DOCTOR,
      page: () => const AboutDoctorView(),
      binding: AboutDoctorBinding(),
    ),
    GetPage(
      name: Routes.CHOOSE_DOCTOR,
      page: () => const ChooseDoctorView(),
      binding: ChooseDoctorBinding(),
    ),
    GetPage(
      name: Routes.SHOPPINT_CART,
      page: () => const ShoppingCartView(),
      binding: ShoppingCartBinding(),
    ),
    // GetPage(
    //   name: Routes.BOOKING_APPOINTMENT,
    //   page: () => AppointmentBookingView(),
    // ),
    GetPage(
      name: Routes.PAYMENT_APPOINTMENT,
      page: () => AppointmentPaymentView(),
    ),
    // GetPage(
    //   name: Routes.APPOINTMENT_ADDRESS,
    //   page: () => AppointmentAddressView(),
    //   binding: AppointmentAddressBinding(),
    // ),
    // GetPage(
    //   name: Routes.CHOOSE_A_DOCTOR,
    //   page: () => const AppointmentChooseDoctorView(),
    //   binding: ChooseADoctorBinding(),
    // ),
    GetPage(
      name: Routes.SERVICES_REVIEWS,
      page: () => const ServicesReviewsView(),
      binding: ServicesReviewsBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_REVIEW,
      page: () => ServiceReviewView(),
      binding: ServiceReviewBinding(),
    ),
    GetPage(
      name: Routes.SERVICE_CANCEL,
      page: () => ServiceCancelView(),
      binding: ServiceCancelBinding(),
    ),
    GetPage(
      name: Routes.APPOINTMENT_MANGMENT,
      page: () => AppointmentMangmentView(),
      binding: AppointmentMangmentBinding(),
    ),
    GetPage(
      name: Routes.ORDERS_LIST,
      page: () => const OrdersListView(),
      binding: OrdersListBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS_DELIVERED,
      page: () => const OrderDetailsDeliveredView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS_UNDERWAY,
      page: () => const OrderDetailsUnderwayView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS_CANCELLED,
      page: () => const OrderDetailsCancelledView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: Routes.ORDER_COMPLETE,
      page: () => OrderCompleteView(),
      binding: OrderCompleteBinding(),
    ),
    // GetPage(
    //   name: Routes.ORDER_REVIEW,
    //   page: () => const OrderReviewView(),
    //   binding: OrderReviewBinding(),
    // ),
    GetPage(
      name: Routes.ORDER_CANCEL,
      page: () => OrderCancelView(),
      binding: OrderCancelBinding(),
    ),
    GetPage(
      name: Routes.DELIVERY_ADDRESSES,
      page: () => const DeliveryAddressesView(),
      binding: DeliveryAddressesBinding(),
    ),
    GetPage(
      name: Routes.ADD_NEW_ADDRESS,
      page: () => AddNewAddressView(),
      binding: AddNewAddressBinding(),
    ),
    GetPage(
      name: Routes.EDIT_APPOINTMENT,
      page: () => EditAppointmentView(),
      binding: EditAppointmentBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PHONE,
      page: () => UpdatePhoneView(),
      binding: UpdatePhoneBinding(),
    ),
    GetPage(
      name: Routes.UPDATE_PHONE_OTP,
      page: () => UpdatePhoneOtpView(),
      binding: UpdatePhoneBinding(),
    ),
    GetPage(
      name: Routes.GOOGLE_MAP,
      page: () => GoogleMapView(),
      binding: GoogleMapBinding(),
    ),
  ];
}
