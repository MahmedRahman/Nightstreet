part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const splash = '/splash';

  static const updateProfile = '/updateProfile';

  static const termsPage = '/TermsPage';
  static const aboutUsPage = '/AboutUsPage';
  static const privacyPolicyPage = '/PrivacyPolicyPage';
  static const faqPage = '/FaqPage';
  static const notificationPage = '/notificationPage';

  //static const complaintsActivePage = '/ComplaintsActivePage';
  static const walletPage = '/walletPage';
  static const OFFER_LIST = '/offer-list';
  static const OFFER_SERVICE_FILTER = '/offer-service-filter';
  static const OFFER_PRODUCT_FILTER = '/offer-product-filter';

  static const TEST = '/test';
  static const HOME_PAGE = '/home-page';
  static const ACCOUNT_MENU = '/account-menu';
  static const LOGIN = '/login';
  static const VERIFY_PHONE = '/verify-phone';
  static const REGISTER = '/register';
  static const GIFT_CARDS = '/gift-cards';
  static const GIFT_CARD_PAYMENT = '/gift-card-payment';
  static const COMPLAINT_ADD_NEW = '/complaint-add-new';
  static const OFFER_HOME = '/offer-home';
  static const COMPLAINT_ACTIVE_LIST = '/complaint-active-list';
  static const COMPLAINT_CLOSED_LIST = '/complaint-closed-list';
  static const COMPLAINT_MANAGER = '/complaint-manager';
  static const COMPLAINT_DETAILS = '/complaint-details';
  static const HOME_PAGE_PRODUCTS = '/home-page-products';
  static const PRODUCTS_LIST = '/products-list';
  static const LAYOUT = '/layout';
  static const HOME_PAGE_SERVICES = '/home-page-services';
  static const FAVORITE = '/favorite';
  static const CLINIC_INFO = '/clinic-info';
  static const PRODUCT_SEARCH = '/product-search';
  static const SERVICES_SEARCH = '/services-search';
  static const SERVICE_DETAIL = '/service-detail';
  static const PRODUCT_DETAILS = '/product-details';
  static const ABOUT_DOCTOR = '/about-doctor';
  static const CHOOSE_DOCTOR = '/choose-doctor';
  static const SHOPPINT_CART = '/shoppint-cart';
  static const BOOKING_APPOINTMENT = '/booking-appointment';
  static const PAYMENT_APPOINTMENT = '/payment-appointment';
  static const APPOINTMENT_ADDRESS = '/appointment-address';
  static const CHOOSE_A_DOCTOR = '/choose-a-doctor';
  static const SERVICES_REVIEWS = '/services-reviews';
  static const SERVICE_REVIEW = '/service-review';
  static const SERVICE_CANCEL = '/service-cancel';
  static const APPOINTMENT_MANGMENT = '/appointment-mangment';
  static const ORDERS_LIST = '/orders-list';
  static const ORDER_DETAILS_DELIVERED = '/order-details-delivered';
  static const ORDER_DETAILS_UNDERWAY = '/order-details-underway';
  static const ORDER_DETAILS_CANCELLED = '/order-details-cancelled';
  static const ORDER_COMPLETE = '/order-complete';
  static const ORDER_REVIEW = '/order-review';
  static const ORDER_CANCEL = '/order-cancel';
  static const DELIVERY_ADDRESSES = '/delivery-addresses';
  static const ADD_NEW_ADDRESS = '/add-new-address';
  static const EDIT_APPOINTMENT = '/edit-appointment';
  static const UPDATE_PHONE = '/update-phone';
  static const UPDATE_PHONE_OTP = '/update-phone-otp';
  static const GOOGLE_MAP = '/google-map';
}
