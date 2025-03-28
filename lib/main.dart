// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector/VIEWS/signin.dart';
import 'package:vector/views/admin_dashboard.dart';
import 'package:vector/views/user_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SignInScreen()),
        GetPage(name: '/user-dashboard', page: () => const UserDashboard()),
        GetPage(name: '/admin-dashboard', page: () => AdminDashboard()),
      ],
    );
  }
}
