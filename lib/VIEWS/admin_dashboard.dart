// lib/views/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector/CONTROLLERS/dashboard_controller.dart';
import 'package:vector/CONTROLLERS/request_controller.dart';
import 'package:vector/CONTROLLERS/course_controller.dart';
import 'package:vector/MODELS/request_model.dart';
import 'package:vector/MODELS/student_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final DashboardController dashboardController = Get.put(DashboardController());
  final RequestController requestController = Get.put(RequestController());
  final CourseController courseController = Get.put(CourseController());
  bool isSidebarOpen = true; // Controls the sidebar state
  String selectedOption = 'Dashboard'; // Tracks the selected option

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: Row(
          children: [
            IconButton(
              icon: Icon(
                isSidebarOpen ? Icons.menu_open : Icons.menu,
                color: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  isSidebarOpen = !isSidebarOpen; // Toggle sidebar state
                });
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Admin',
              style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFE8F5E9), // Same color as sidebar
        elevation: 4.0, // Adds shadow under the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.green),
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
      body: Row(
        children: [
          // Sidebar
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isSidebarOpen ? 200 : 0, // Sidebar width
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
            child: selectedOption == 'Dashboard'
                ? _buildDashboardPage(screenWidth)
                : selectedOption == 'Requests'
                    ? _buildRequestsPage()
                    : _buildDepartmentPage(screenWidth),
          ),
        ],
      ),
    );
  }

  // Sidebar Option Widget
  Widget _buildSidebarOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
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
        if (MediaQuery.of(context).size.width < 600) Navigator.pop(context); // Close drawer on mobile
      },
    );
  }

  // Dashboard Page
  Widget _buildDashboardPage(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashboard Stats
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildDashboardStat("Total Courses", dashboardController.totalCourses.value, screenWidth),
              _buildDashboardStat("Total Students", dashboardController.totalStudents.value, screenWidth),
              _buildDashboardStat("Pending Requests", dashboardController.pendingRequests.value, screenWidth),
              _buildDashboardStat("Documents Awaiting Pickup", dashboardController.documentsAwaitingPickup.value, screenWidth),
            ],
          ),
          const SizedBox(height: 32),
          // Recent Activity
          const Text(
            "RECENT ACTIVITY",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: dashboardController.recentActivity.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      dashboardController.recentActivity[index],
                      style: const TextStyle(color: Colors.green),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Dashboard Stat Widget
  Widget _buildDashboardStat(String title, int value, double screenWidth) {
    return SizedBox(
      width: screenWidth < 600 ? double.infinity : 200, // Full width on mobile
      child: Card(
        color: const Color(0xFFE8F5E9),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 8),
              Text(
                value.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Department Page
  Widget _buildDepartmentPage(double screenWidth) {
    return Obx(() {
      final selectedCourse = courseController.selectedCourse.value;
      final students = courseController.studentsForSelectedCourse;

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                courseController.selectedCourse.value = ""; // Reset selected course
              },
              child: const Text(
                "COURSES",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            const SizedBox(height: 16),
            if (selectedCourse.isEmpty)
              Expanded(
                child: GridView.count(
                  crossAxisCount: screenWidth < 600 ? 2 : 3, // Adjust grid columns for mobile
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildCourseCategory("PG COURSES", courseController.pgCourses),
                    _buildCourseCategory("UNDERGRADUATE", courseController.ugCourses),
                    _buildCourseCategory("INTEGRATED", courseController.integratedCourses),
                  ],
                ),
              )
            else
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selected course title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Students in $selectedCourse",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    // List of students
                    Expanded(
                      child: students.isEmpty
                          ? const Center(
                              child: Text(
                                "No students in this course.",
                                style: TextStyle(color: Colors.green),
                              ),
                            )
                          : ListView.builder(
                              itemCount: students.length,
                              itemBuilder: (context, index) {
                                final student = students[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: ListTile(
                                    title: Text(
                                      student.name,
                                      style: const TextStyle(color: Colors.green),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Reg No: ${student.regNo}", style: const TextStyle(color: Colors.green)),
                                        Text("Status: ${student.status}", style: const TextStyle(color: Colors.green)),
                                        const SizedBox(height: 8.0),
                                        const Text(
                                          "Application History:",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                        ),
                                        ...student.applicationHistory
                                            .map((history) => Text("- $history", style: const TextStyle(color: Colors.green)))
                                            .toList(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  // Course Category Widget
  Widget _buildCourseCategory(String title, List<String> courses) {
    return Card(
      color: const Color(0xFFE8F5E9),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 8),
            ...courses.map((course) {
              return InkWell(
                onTap: () {
                  courseController.selectedCourse.value = course;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text("- $course", style: const TextStyle(color: Colors.green)),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Requests Page with Tabs
  Widget _buildRequestsPage() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            color: const Color(0xFFE8F5E9), // Sidebar color for tabs
            child: const TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: 'Current'),
                Tab(text: 'Pending'),
                Tab(text: 'Completed'),
                Tab(text: 'Rejected'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildCurrentRequestsTable(),
                _buildPendingRequestsTable(),
                _buildCompletedRequestsTable(),
                _buildRejectedRequestsTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Current Requests Table
  Widget _buildCurrentRequestsTable() {
    return Obx(() => Container(
          color: const Color(0xFFE8F5E9),
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('regNo')),
              DataColumn(label: Text('Doc_requested')),
              DataColumn(label: Text('Status')),
            ],
            rows: requestController.currentRequests.map((request) {
              return DataRow(cells: [
                DataCell(Text(request.no)),
                DataCell(Text(request.name)),
                DataCell(Text(request.regNo)),
                DataCell(Text(request.docRequested)),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        requestController.acceptRequest(request);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Accept'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showRejectDialog(request);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Reject'),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          ),
        ));
  }

  // Pending Requests Table
  Widget _buildPendingRequestsTable() {
    return Obx(() => Container(
          color: const Color(0xFFE8F5E9),
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('regNo')),
              DataColumn(label: Text('Doc_requested')),
            ],
            rows: requestController.pendingRequests.map((request) {
              return DataRow(cells: [
                DataCell(Text(request.no)),
                DataCell(Text(request.name)),
                DataCell(Text(request.regNo)),
                DataCell(Text(request.docRequested)),
              ]);
            }).toList(),
          ),
        ));
  }

  // Completed Requests Table
  Widget _buildCompletedRequestsTable() {
    return Obx(() => Container(
          color: const Color(0xFFE8F5E9),
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('regNo')),
              DataColumn(label: Text('Doc_requested')),
            ],
            rows: requestController.completedRequests.map((request) {
              return DataRow(cells: [
                DataCell(Text(request.no)),
                DataCell(Text(request.name)),
                DataCell(Text(request.regNo)),
                DataCell(Text(request.docRequested)),
              ]);
            }).toList(),
          ),
        ));
  }

  // Rejected Requests Table
  Widget _buildRejectedRequestsTable() {
    return Obx(() => Container(
          color: const Color(0xFFE8F5E9),
          padding: const EdgeInsets.all(16.0),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('No')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('regNo')),
              DataColumn(label: Text('Doc_requested')),
              DataColumn(
                label: Text(
                  'Review',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
            rows: requestController.rejectedRequests.map((request) {
              return DataRow(cells: [
                DataCell(Text(request.no)),
                DataCell(Text(request.name)),
                DataCell(Text(request.regNo)),
                DataCell(Text(request.docRequested)),
                DataCell(Text(
                  request.review ?? '',
                  style: const TextStyle(color: Colors.red),
                )),
              ]);
            }).toList(),
          ),
        ));
  }

  // Show Reject Dialog
  void _showRejectDialog(RequestModel request) {
    final TextEditingController reviewController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reject Request'),
          content: TextField(
            controller: reviewController,
            decoration: const InputDecoration(
              labelText: 'Enter reason for rejection',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                requestController.rejectRequest(request, reviewController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
