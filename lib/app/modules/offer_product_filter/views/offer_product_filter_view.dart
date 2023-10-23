import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/offer_product_filter_controller.dart';

class OfferProductFilterView extends GetView<OfferProductFilterController> {
  const OfferProductFilterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OfferProductFilterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OfferProductFilterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
