// lib/views/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vector/CONTROLLERS/request_controller.dart';
import 'package:vector/MODELS/request_model.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final RequestController controller = Get.put(RequestController());
  bool isSidebarOpen = true; // Controls the sidebar state
  String selectedOption = 'Dashboard'; // Tracks the selected option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.green),
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
            child: selectedOption == 'Requests'
                ? _buildRequestsPage()
                : Center(
                    child: Text(
                      '$selectedOption Page',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
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
            rows: controller.currentRequests.map((request) {
              return DataRow(cells: [
                DataCell(Text(request.no)),
                DataCell(Text(request.name)),
                DataCell(Text(request.regNo)),
                DataCell(Text(request.docRequested)),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.acceptRequest(request);
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
            rows: controller.pendingRequests.map((request) {
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
            rows: controller.completedRequests.map((request) {
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
            rows: controller.rejectedRequests.map((request) {
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
                controller.rejectRequest(request, reviewController.text);
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
