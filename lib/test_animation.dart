import 'package:flutter/material.dart';

class TextAnimationWidget extends StatefulWidget {
  @override
  _TextAnimationWidgetState createState() => _TextAnimationWidgetState();
}

class _TextAnimationWidgetState extends State<TextAnimationWidget> {
  String currentText = "Text 1";
  int textIndex = 1;

  List<String> textList = ["Text", "length", "lolo"];

  void changeText() {
    setState(() {
      textIndex = (textIndex + 1) % textList.length;
      currentText = textList[textIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Text(
              currentText,
              key: Key(
                  currentText), // Key to distinguish between different Text widgets
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: changeText,
            child: Text("Change Text"),
          ),
        ],
      ),
    );
  }
}
