import 'package:flutter/material.dart';

class SubWindowApp extends StatelessWidget {
  final int windowId;

  const SubWindowApp(this.windowId, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '子窗口',
      home: Scaffold(
        appBar: AppBar(title: Text('子窗口 $windowId')),
        body: Center(
          child: Text('这是子窗口 ID: $windowId'),
        ),
      ),
    );
  }
}
