import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../states/user.dart';
import 'home.dart';

class HomeInit extends StatelessWidget {
  final user = Get.put(User());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<User>(
          init: User(),
          builder: (_) => user.currentUser.value.id == null
              ? Center(child: LinearProgressIndicator())
              : HomePage()),
    );
  }
}
