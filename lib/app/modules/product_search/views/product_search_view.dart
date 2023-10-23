import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/pages/app_page_empty.dart';
import 'package:krzv2/component/views/product_search_app_bar_view.dart';
import 'package:krzv2/component/views/scaffold/base_scaffold.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchView extends GetView<ProductSearchController> {
  ProductSearchView({Key? key}) : super(key: key);

  final searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: ProductSearchAppBarView(
        textEditingController: searchTextController,
        onSearchIconTapped: () {},
      ),
      body: AppPageEmpty.productSearchP(),
    );
  }
}
