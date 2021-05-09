import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/extension.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Text('Success').alignCenter,
        ),
      ),
    );
  }
}
