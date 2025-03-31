import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Responsiveness.dart';
import 'dashboard_view.dart';
import 'requests_view.dart';
import 'department_view.dart';
import '../CONTROLLERS/course_controller.dart';
import '../CONTROLLERS/request_controller.dart';
import '../CONTROLLERS/dashboard_controller.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool isSidebarOpen = true; // Controls the sidebar state
  String selectedOption = 'Dashboard'; // Tracks the selected option

  @override
  void initState() {
    super.initState();
    // Initialize all required controllers
    Get.put(CourseController()); // For DepartmentView
    Get.put(RequestController()); // For RequestsView
    Get.put(DashboardController()); // For DashboardView
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _buildMobileLayout(),
      tablet: _buildTabletLayout(),
      desktop: _buildDesktopLayout(),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Ensures the menu icon is displayed
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 4.0,
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Admin ID: A12345", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Designation: HOD", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            _buildSidebarOption('Dashboard', Icons.dashboard),
            _buildSidebarOption('Requests', Icons.request_page),
            _buildSidebarOption('Department', Icons.apartment),
          ],
        ),
      ),
      body: _buildContent(),
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 4.0,
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Admin ID: A12345", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Designation: HOD", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: const Color(0xFFE8F5E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildSidebarOption('Dashboard', Icons.dashboard),
                _buildSidebarOption('Requests', Icons.request_page),
                _buildSidebarOption('Department', Icons.apartment),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE8F5E9),
        elevation: 4.0,
        actions: [
          PopupMenuButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Admin ID: A12345", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("Designation: HOD", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarOpen ? 200 : 0,
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
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarOption(String title, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: SizedBox(
        width: 24,
        child: Icon(icon, color: Colors.green),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
      onTap: () {
        setState(() {
          selectedOption = title; // Update selected option
        });
        if (Responsive.isMobile(context)) Navigator.pop(context); // Close drawer on mobile
      },
    );
  }

  Widget _buildContent() {
    if (selectedOption == 'Dashboard') {
      return const DashboardView();
    } else if (selectedOption == 'Requests') {
      return const RequestsView();
    } else if (selectedOption == 'Department') {
      return const DepartmentView();
    } else {
      return const Center(
        child: Text(
          'Page not found',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    }
  }
}
