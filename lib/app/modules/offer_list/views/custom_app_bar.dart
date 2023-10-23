



// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:krzv2/services/auth_services.dart';

// class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final VoidCallback onCartTapped;
//   final VoidCallback onNotificationTapped;
//   final VoidCallback onLogoutTapped;
//   final VoidCallback onLoginTapped;

//   final int? notificationCounter;
//   final int? cartItemsCounter;

//   HomeAppBar({
//     super.key,
//     required this.onCartTapped,
//     required this.onNotificationTapped,
//     required this.onLogoutTapped,
//     required this.onLoginTapped,
//     this.cartItemsCounter = 0,
//     this.notificationCounter = 0,
//   });
//   final authController = Get.find<AuthenticationController>();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: false,
//       // automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,

//       elevation: 0.0,
//       leading: IconButton(
//         icon: const Icon(
//           Icons.menu,
//           color: Colors.black,
//         ),
//         onPressed: () => Scaffold.of(context).openDrawer(),
//       ),

//       title: const 
      
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'استكشــف',
//             style: TextStyle(
//               fontSize: 14.0,
//               color: AppColors.mainColor,
//               letterSpacing: 0.42,
//               height: 0.86,
//             ),
//             textAlign: TextAlign.right,
//           ),
//           Spacers.height10,
//           Text(
//             'أقوى العروض',
//             style: TextStyle(
//               fontSize: 16.0,
//               color: AppColors.blackColor,
//               letterSpacing: 0.64,
//               fontWeight: FontWeight.w500,
//               height: 0.75,
//             ),
//             textAlign: TextAlign.right,
//           ),
//         ],
//       ),
     
     
//       actions: [
//         CustomIconButton(
//           onTap: onCartTapped,
//           iconPath: SvgAssets.cartIcon,
//           count: cartItemsCounter,
//         ),
//         if (authController.isLoggedIn)
//           CustomIconButton(
//             onTap: onNotificationTapped,
//             iconPath: SvgAssets.notificationIcon,
//             count: notificationCounter,
//           ),
//         Spacers.width20,
//       ],
//     );
//   }
// }