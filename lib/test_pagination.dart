import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPaginationScreen(),
    );
  }
}

class MyPaginationScreen extends StatefulWidget {
  @override
  _MyPaginationScreenState createState() => _MyPaginationScreenState();
}

class _MyPaginationScreenState extends State<MyPaginationScreen> {
  ScrollController _scrollController = ScrollController();
  List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Calculate a threshold value based on the screen height
    double threshold = 0.9 * MediaQuery.of(context).size.height;

    // Trigger loading next page when the user is near the last item plus the threshold
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - threshold) {
      _loadNextPage();
    }
  }

  void _loadNextPage() {
    // Simulate loading data from an API (replace this with your actual data fetching logic)
    List<String> nextPage = List.generate(20, (index) => 'Item ${items.length + index}');

    // Update the state with the new data
    setState(() {
      items.addAll(nextPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagination Example'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}