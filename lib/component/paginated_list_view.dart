// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:krzv2/component/center_loading.dart';

class PaginatedListView<ItemType> extends StatelessWidget {
  final PagingController<int, ItemType> controller;

  final Widget firstLoadingIndicator;
  final Widget Function(BuildContext, ItemType, int) itemBuilder;
  final Widget? loadingMoreIndicator;

  const PaginatedListView({
    Key? key,
    required this.controller,
    required this.firstLoadingIndicator,
    this.loadingMoreIndicator,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, ItemType>(
      key: UniqueKey(),
      pagingController: controller,
      builderDelegate: builder(),
    );
  }

  PagedChildBuilderDelegate<ItemType> builder() {
    return PagedChildBuilderDelegate<ItemType>(
      firstPageProgressIndicatorBuilder: (_) => firstLoadingIndicator,
      newPageProgressIndicatorBuilder: (_) =>
          loadingMoreIndicator ?? CenterLoading(),
      itemBuilder: itemBuilder,
    );
  }
}
