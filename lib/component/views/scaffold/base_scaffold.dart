import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krzv2/component/views/bottom_navigation_bar_view.dart';
import 'package:krzv2/utils/app_colors.dart';

var KSelectIndex = 0.obs;

class BaseScaffold extends StatelessWidget {
  BaseScaffold({
    required this.body,
    this.actions,
    this.appBar,
    this.bottomNavigationBar,
    this.bottomBarHeight = 90,
    this.onRefresh,
  });

  final Widget body;
  final List<Widget>? actions;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final double? bottomBarHeight;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    return onRefresh == null
        ? Scaffold(
            appBar: appBar,
            body: body,
            bottomNavigationBar: MediaQuery.removePadding(
              context: context,
              child: SizedBox(
                height: bottomBarHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: bottomNavigationBar ?? SizedBox.shrink(),
                    ),
                    BottomNavigationBarView(),
                  ],
                ),
              ),
              removeBottom: true,
            ),
          )
        : RefreshIndicator(
            color: AppColors.mainColor,
            onRefresh: onRefresh ?? () async {},
            child: Scaffold(
              appBar: appBar,
              body: body,
              bottomNavigationBar: MediaQuery.removePadding(
                context: context,
                child: SizedBox(
                  height: bottomBarHeight,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: bottomNavigationBar ?? SizedBox.shrink(),
                      ),
                      BottomNavigationBarView(),
                    ],
                  ),
                ),
                removeBottom: true,
              ),
            ),
          );
  }
}

class BaseScaffoldBlank extends StatelessWidget {
  BaseScaffoldBlank({required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }
}
