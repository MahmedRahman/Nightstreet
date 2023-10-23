import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_doctor_controller.dart';

class ChooseDoctorView extends GetView<ChooseDoctorController> {
  const ChooseDoctorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChooseDoctorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChooseDoctorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
