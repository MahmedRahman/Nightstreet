import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/component/center_loading.dart';

class PaginatedGridView<ItemType> extends StatelessWidget {
  final PagingController<int, ItemType> controller;

  final Widget firstLoadingIndicator;
  final Widget onEmpty;
  final Widget Function(BuildContext, ItemType, int) itemBuilder;
  final Widget? loadingMoreIndicator;

  const PaginatedGridView({
    Key? key,
    required this.controller,
    required this.firstLoadingIndicator,
    required this.onEmpty,
    this.loadingMoreIndicator,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemHeight = (Get.height - kToolbarHeight - 24) / 1;
    final double itemWidth = Get.width / 2;
    return PagedGridView<int, ItemType>(
      key: UniqueKey(),
      pagingController: controller,
      builderDelegate: builder(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight) / .38,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }

  PagedChildBuilderDelegate<ItemType> builder() {
    return PagedChildBuilderDelegate<ItemType>(
      firstPageProgressIndicatorBuilder: (_) => firstLoadingIndicator,
      newPageProgressIndicatorBuilder: (_) =>
          loadingMoreIndicator ?? CenterLoading(),
      itemBuilder: itemBuilder,
      noItemsFoundIndicatorBuilder: (_) => onEmpty,
    );
  }
}
