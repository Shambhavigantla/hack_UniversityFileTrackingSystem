// lib/views/user_dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
      ),
      body: Center(
        child: Text('Welcome, ${user.username}!'),
      ),
    );
  }
}
