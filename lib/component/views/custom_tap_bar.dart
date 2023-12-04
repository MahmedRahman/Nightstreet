import 'package:flutter/material.dart';
import 'package:krzv2/utils/app_colors.dart';

class CustomTapBar extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;

  const CustomTapBar({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.widget1,
    required this.widget2,
    required this.widget3,
  }) : super(key: key);
  @override
  _CustomTapBarState createState() => _CustomTapBarState();
}

class _CustomTapBarState extends State<CustomTapBar>
    with SingleTickerProviderStateMixin {
  List<Widget>? myTabs;

  TabController? _tabController;
  int _tabIndex = 0;

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    myTabs = [
      Tab(text: widget.label1),
      Tab(text: widget.label2),
      Tab(text: widget.label3),
    ];
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController!.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          labelColor: AppColors.blackColor,
          indicatorColor: AppColors.mainColor,
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          isScrollable: true,
          tabs: myTabs!,
        ),
        Center(
          child: [
            widget.widget1,
            widget.widget2,
            widget.widget3,
          ][_tabIndex],
        ),
      ],
    );
  }
}
