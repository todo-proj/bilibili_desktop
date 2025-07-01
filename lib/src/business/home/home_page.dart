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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: (){
              context.go('/login');
            },
              child: Text('data')),
        ),
      ),
    );
  }

}
