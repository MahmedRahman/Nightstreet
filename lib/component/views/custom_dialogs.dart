import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/component/views/costum_btn_component.dart';
import 'package:krzv2/routes/app_pages.dart';
import 'package:krzv2/utils/app_colors.dart';
import 'package:krzv2/utils/app_spacers.dart';
import 'package:krzv2/utils/app_svg_paths.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AppDialogs {
  AppDialogs._();

  static showToast({required String message}) {
    return showTopSnackBar(
      Overlay.of(Get.context!),
      CustomSnackBar.error(
        message: message,
        backgroundColor: AppColors.mainColor,
      ),
      displayDuration: Duration(milliseconds: 200),
    );
  }

  factory AppDialogs.forceDialog({required Function() onTap}) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: onTap,
      title: "",
      subtitle: "",
      image: "",
    );
    return appDialogs;
  }

  factory AppDialogs.errorDialog({required String msg}) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () => Get.back(),
      title: "خطأ",
      subtitle: msg,
      image: AppSvgAssets.errorIconDialog,
      imageWidth: 150,
      imageHeight: 150,
      child: CustomBtnCompenent.main(
        text: 'رجوع',
        width: 240,
        onTap: () => Get.back(),
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.loginSuccess() {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      barrierDismissible: false,
      subtitle:
          "حسابك جاهز للاستخدام ، ستتم إعادة توجيهك\nإلى الصفحة الرئيسية في بضع ثوان",
      image: AppSvgAssets.successIcon,
      child: SpinKitCircle(
        color: AppColors.mainColor,
        size: 70,
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.addAddressSuccess() {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle:
          "تم إضافة العنوان بنجاح ، ستتم إعادة توجيهك \n إلى صفحة العناويين في بضع ثوان",
      image: AppSvgAssets.successIcon,
      child: SpinKitCircle(
        color: AppColors.mainColor,
        size: 70,
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.giftCartPaymentSuccess() {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle:
          'تمت العملية بنجاح ، وسنرسل إليك رسالة\nتأكيد عبر البريد الإلكتروني قريبًا.',
      image: AppSvgAssets.successIcon,
      barrierDismissible: false,
      child: CustomBtnCompenent.main(
        text: 'الرئيسية',
        width: 240,
        onTap: () {
          Get.offAndToNamed(Routes.LAYOUT);
        },
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.giftCartPaymentFailed() {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "مش مبسوط !!",
      subtitle: 'عندك مشكله ياواد',
      image: AppSvgAssets.successIcon,
      barrierDismissible: false,
      child: CustomBtnCompenent.main(
        text: 'الرئيسية',
        width: 240,
        onTap: () {
          Get.offAndToNamed(Routes.LAYOUT);
        },
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.complaintAddNewSuccessful(
      {required void Function() onTap}) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle:
          'تم تقديم التذكرة بنجاح ، وسنرسل إليك رسالة \n تأكيد عبر البريد الإلكتروني قريبًا.',
      image: AppSvgAssets.successIcon,
      barrierDismissible: false,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: 'عرض جميع الشكاوي',
            width: 240,
            onTap: onTap,
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'الرئيسية',
            width: 240,
            onTap: () {
              Get.offAndToNamed(Routes.LAYOUT);
            },
          ),
        ],
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.locationPermissionDialog(
      {required void Function() onTap}) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "نتبية !!",
      imageHeight: 100,
      imageWidth: 100,
      dialogHeight: 380,
      subtitle: 'هذه الخدمة تتطلب إذن الموقع',
      image: AppSvgAssets.locationServiceIcon,
      barrierDismissible: true,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: 'فتح الإعدادات',
            width: 240,
            onTap: onTap,
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'إلغاء',
            width: 240,
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.appointmentBookingSuccess() {
    final bottomNavigationController = Get.find<MyBottomNavigationController>();
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle: 'تم الحجز بنجاح وسيتم اشعاركم فور تأكيد\nالحجز من قبل العيادة',
      image: AppSvgAssets.successIcon,
      barrierDismissible: false,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: 'عرض جميع المواعيد',
            width: 240,
            onTap: () {
              bottomNavigationController.changePage(4);
              Get.toNamed(Routes.APPOINTMENT_MANGMENT);
            },
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'الرئيسية',
            width: 240,
            onTap: () {
              Get.offAndToNamed(Routes.LAYOUT);
            },
          ),
        ],
      ),
    );
    return appDialogs;
  }
  factory AppDialogs.deleteAccountDialog({
    required Function() onDelete,
  }) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تحذير !!",
      subtitle: "هل انت متاكد من حف الحساب ؟",
      image: AppSvgAssets.successIcon,
      barrierDismissible: false,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: 'حذف',
            width: 240,
            onTap: onDelete,
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'رجوع',
            width: 240,
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.appointmentUpdateBookingSuccess() {
    final bottomNavigationController = Get.find<MyBottomNavigationController>();
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle:
          'تم تأكيد طلبك ، وسنرسل إليك رسالة تأكيد \n عبر البريد الإلكتروني قريبًا.',
      image: AppSvgAssets.editAppointmentIcon,
      barrierDismissible: false,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: "عرض جميع مواعيدي",
            width: 240,
            onTap: () {
              bottomNavigationController.changePage(4);
              Get.toNamed(Routes.APPOINTMENT_MANGMENT);
            },
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'الرئيسية',
            width: 240,
            onTap: () {
              Get.offAndToNamed(Routes.LAYOUT);
            },
          ),
        ],
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.oderConfirmed() {
    final bottomNavigationController = Get.find<MyBottomNavigationController>();
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      onTap: () {},
      title: "تهانينا !!",
      subtitle:
          'تم تأكيد طلبك ، وسنرسل إليك رسالة تأكيد \n عبر البريد الإلكتروني قريبًا.',
      image: AppSvgAssets.editAppointmentIcon,
      barrierDismissible: false,
      child: Column(
        children: [
          CustomBtnCompenent.main(
            text: "عرض جميع طلباتي",
            width: 240,
            onTap: () {
              bottomNavigationController.changePage(4);
              Get.toNamed(Routes.ORDERS_LIST);
            },
          ),
          AppSpacers.height12,
          CustomBtnCompenent.secondary(
            text: 'الرئيسية',
            width: 240,
            onTap: () {
              Get.offAndToNamed(Routes.LAYOUT);
            },
          ),
        ],
      ),
    );
    return appDialogs;
  }

  factory AppDialogs.loginFailure({
    required String subtitle,
    String title = "خطأ",
  }) {
    final appDialogs = AppDialogs._();
    appDialogs._dialog(
      title: title,
      subtitle: subtitle,
      image: "",
    );
    return appDialogs;
  }

  void _dialog({
    Function()? onTap,
    required String title,
    required String subtitle,
    required String image,
    Widget? child,
    double? imageWidth,
    double? imageHeight,
    double? dialogHeight,
    bool barrierDismissible = true,
  }) {
    Get.generalDialog(
      barrierDismissible: barrierDismissible,
      barrierLabel:
          MaterialLocalizations.of(Get.context!).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            width: Get.width * .8,
            height: dialogHeight ?? 440,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSpacers.height25,
                SvgPicture.asset(
                  image,
                  width: imageWidth,
                  height: imageHeight,
                ),
                AppSpacers.height19,
                TitleBuilder(
                  title: title,
                ),
                DescriptionBuilder(
                  description: subtitle,
                ),
                AppSpacers.height19,
                if (child != null)
                  child
                else
                  onTap == null
                      ? const SizedBox.shrink()
                      : CustomBtnCompenent.main(
                          text: 'تحديث الأن',
                          width: 240,
                          onTap: onTap,
                        ),
                AppSpacers.height25,
              ],
            ),
          ),
        );
      },
    );
  }
}

class DescriptionBuilder extends StatelessWidget {
  final String description;
  const DescriptionBuilder({
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16.0,
        color: AppColors.greyColor,
        height: 2.19,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class TitleBuilder extends StatelessWidget {
  final String title;
  const TitleBuilder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        color: AppColors.blackColor,
        letterSpacing: 0.9,
        fontWeight: FontWeight.w500,
        height: 0.56,
      ),
      textAlign: TextAlign.center,
    );
  }
}
