// lib/views/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isSidebarOpen = true; // Controls the sidebar state
  String selectedOption = 'Dashboard'; // Tracks the selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Bar with Borderline
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9), // Same color as sidebar
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 158, 158, 158), // Stroke line color
                  width: 1.0, // Stroke line thickness
                ),
              ),
            ),
            child: AppBar(
              title: const Text(
                'Admin',
                style: TextStyle(color: Colors.green), // Text color in green
              ),
              backgroundColor: Colors.transparent, // Transparent to show container color
              elevation: 0, // Remove AppBar shadow
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.green), // Icon color in green
                onPressed: () {
                  setState(() {
                    isSidebarOpen = !isSidebarOpen; // Toggle sidebar state
                  });
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.green), // Icon color in green
                  onPressed: () {
                    // Handle notifications
                  },
                ),
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          // Main Content with Sidebar
          Expanded(
            child: Row(
              children: [
                // Sidebar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSidebarOpen ? 200 : 0, // Adjust width dynamically
                  color: const Color(0xFFE8F5E9),
                  child: isSidebarOpen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            _buildSidebarOption('Dashboard', Icons.dashboard),
                            _buildSidebarOption('Requests', Icons.request_page),
                            _buildSidebarOption('Department', Icons.apartment),
                          ],
                        )
                      : null,
                ),
                // Main Content
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        _getContentForSelectedOption(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar Option Widget
  Widget _buildSidebarOption(String title, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = title; // Update selected option
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get Content for Selected Option
  String _getContentForSelectedOption() {
    switch (selectedOption) {
      case 'Dashboard':
        return 'Welcome to the Dashboard!';
      case 'Requests':
        return 'Here are the Requests!';
      case 'Department':
        return 'Department Information!';
      default:
        return 'Welcome to the Admin Dashboard!';
    }
  }
}
