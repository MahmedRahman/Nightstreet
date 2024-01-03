import 'package:app_night_street/core/app_color.dart';
import 'package:app_night_street/core/app_dimensions.dart';
import 'package:flutter/material.dart';

class CustomTapBar4Taps extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final String label4;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final Widget widget4;

  const CustomTapBar4Taps({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.label4,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    required this.widget4,
  }) : super(key: key);
  @override
  _CustomTapBar4TapsState createState() => _CustomTapBar4TapsState();
}

class _CustomTapBar4TapsState extends State<CustomTapBar4Taps>
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
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    myTabs = [
      Tab(text: widget.label1),
      Tab(text: widget.label2),
      Tab(text: widget.label3),
      Tab(text: widget.label4),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: AppColor.KOrangeColor,
          unselectedLabelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 13,
            color: const Color(0xffababb7),
            fontWeight: FontWeight.w600,
          ),
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 13,
            color: const Color(0xfff26404),
            fontWeight: FontWeight.w600,
          ),
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
          padding: AppDimension.appPadding,
          tabs: myTabs!,
          indicatorSize: TabBarIndicatorSize.label,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              widget.widget1,
              widget.widget2,
              widget.widget3,
              widget.widget4,
            ],
          ),
        )
      ],
    );
  }
}
