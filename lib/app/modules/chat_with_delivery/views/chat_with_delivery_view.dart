import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:app_night_street/core/component/base_body.dart';
import 'package:app_night_street/core/component/cashed_network_image_view.dart';
import 'package:app_night_street/core/component/custom_button.dart';
import 'package:app_night_street/core/component/order_app_bar.dart';
import 'package:app_night_street/core/component/rounded_text_field.dart';
import 'package:app_night_street/core/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/chat_with_delivery_controller.dart';

class ChatWithDeliveryView extends GetView<ChatWithDeliveryController> {
  const ChatWithDeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: OrderAppBar(
        title: 'تواصل مع المندوب',
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _body(),
          _deliveryImage(),
          _sendMessageButton(),
        ],
      ),
    );
  }

  Padding _sendMessageButton() {
    return Padding(
      padding: AppDimension.appPadding.copyWith(bottom: 30),
      child: RoundedTextField(
        backGroundColor: Color(0xffF4F4F4),
        borderColor: Color(0xffD5D5D5),
        labelText: "رسالتك هنا",
        maxLines: 1,
        suffixIcon: InkWell(
          onTap: () => print('tapped'),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset("images/svg/send_message.svg"),
          ),
        ),
        onChanged: (String text) {},
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.only(
        top: kToolbarHeight,
      ),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(37),
          topRight: Radius.circular(37),
        ),
      ),
      child: ListView(
        padding: AppDimension.appPadding.copyWith(top: 40),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _userImage(),
              SizedBox(width: 5),
              Expanded(
                child: myMessage(
                  message: 'السلام عليكم ، كيف حالك',
                  messageTime: '17:45',
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          deliveryMessage(
            message: 'السلام عليكم ، كيف حالك',
            messageTime: '17:45',
          )
        ],
      ),
    );
  }

  Container deliveryMessage({
    required String message,
    required String messageTime,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xfff26404),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        border: Border.all(width: 1.0, color: const Color(0x00000000)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                Text(
                  "عليكم السلام و رحمة الله",
                  style: TextStyles.font12RegularWhite,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "18:04",
                  style: TextStyles.font12RegularWhite,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container myMessage({
    required String message,
    required String messageTime,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: const Color(0xff444251),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Row(
              children: [
                Text(
                  message,
                  style: TextStyles.font12RegularWhite,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  messageTime,
                  style: TextStyles.font12RegularWhite.copyWith(
                    color: Color(0xffcccccc),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliveryImage() {
    return Positioned(
      top: kToolbarHeight / 20,
      child: Container(
        height: 89,
        width: 89,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: CashedNetworkImageView(
          imageUrl:
              'https://cdn3.iconfinder.com/data/icons/delivery-services-2/64/delivery-guy-man-avatar-food-service-1024.png',
        ),
      ),
    );
  }

  Widget _userImage() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: AppColor.KOrangeColor,
    );
  }
}
