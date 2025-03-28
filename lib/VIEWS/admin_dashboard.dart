// lib/views/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../Responsiveness.dart';

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
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(color: Colors.green), // Text color in green
        ),
        backgroundColor: const Color(0xFFE8F5E9), // Same color as sidebar
        elevation: 4.0, // Adds shadow under the AppBar
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
      body: Responsive(
        mobile: _buildMobileLayout(),
        tablet: _buildTabletLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return Stack(
      children: [
        // Main Content
        Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Mobile View: $selectedOption',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // Sidebar Overlay
        if (isSidebarOpen)
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 200,
              color: const Color(0xFFE8F5E9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSidebarOption('Dashboard', Icons.dashboard),
                  _buildSidebarOption('Requests', Icons.request_page),
                  _buildSidebarOption('Department', Icons.apartment),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        isSidebarOpen = false; // Close the sidebar
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout() {
    return Row(
      children: [
        // Sidebar
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isSidebarOpen ? 150 : 0, // Adjust width dynamically
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
          child: Center(
            child: Text(
              'Tablet View: $selectedOption',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout() {
    return Row(
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
          child: Center(
            child: Text(
              'Desktop View: $selectedOption',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // Sidebar Option Widget
  Widget _buildSidebarOption(String title, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = title; // Update selected option
          if (Responsive.isMobile(context)) {
            isSidebarOpen = false; // Close sidebar on mobile after selection
          }
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
}
