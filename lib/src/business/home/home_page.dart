import 'package:bilibili_desktop/src/business/common/system_titlebar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 200,
              color: Colors.red,
              child: Column(
                children: [
                  IconButton(icon: Icon(Icons.telegram), onPressed: (){
                    context.go('/login');
                  })
                ],
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SystemTitleBar(),

              ],
            ),
          ),
        ],
      ),
    );
  }

}
