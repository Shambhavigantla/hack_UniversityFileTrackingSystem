import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CONTROLLERS/request_controller.dart';
import '../MODELS/request_model.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RequestController requestController = Get.find();

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
                _buildCurrentRequestsTable(requestController),
                _buildPendingRequestsTable(requestController, context),
                _buildCompletedRequestsTable(requestController),
                _buildRejectedRequestsTable(requestController),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Current Requests Table
  Widget _buildCurrentRequestsTable(RequestController requestController) {
    return Obx(() => _buildRequestsTable(
          requestController.currentRequests,
          showStatus: true,
          requestController: requestController,
        ));
  }

  // Pending Requests Table
  Widget _buildPendingRequestsTable(RequestController requestController, BuildContext context) {
    return Obx(() => _buildRequestsTable(
          requestController.pendingRequests,
          showUploadButton: true,
          requestController: requestController,
          context: context,
        ));
  }

  // Completed Requests Table
  Widget _buildCompletedRequestsTable(RequestController requestController) {
    return Obx(() => _buildRequestsTable(
          requestController.completedRequests,
          showViewButton: true,
        ));
  }

  // Rejected Requests Table
  Widget _buildRejectedRequestsTable(RequestController requestController) {
    return Obx(() => _buildRequestsTable(
          requestController.rejectedRequests,
          showReview: true,
        ));
  }

  // Generalized Requests Table
  Widget _buildRequestsTable(
    List<RequestModel> requests, {
    bool showStatus = false,
    bool showUploadButton = false,
    bool showViewButton = false,
    bool showReview = false,
    RequestController? requestController,
    BuildContext? context,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: DataTable(
        columns: [
          const DataColumn(label: Text('No')),
          const DataColumn(label: Text('Name')),
          const DataColumn(label: Text('Reg No')),
          const DataColumn(label: Text('Doc Requested')),
          const DataColumn(label: Text('Required Document')),
          if (showStatus) const DataColumn(label: Text('Status')),
          if (showUploadButton) const DataColumn(label: Text('Upload Document')),
          if (showViewButton) const DataColumn(label: Text('View Document')),
          if (showReview) const DataColumn(label: Text('Review')),
        ],
        rows: requests.map((request) {
          return DataRow(cells: [
            DataCell(Text(request.no)),
            DataCell(Text(request.name)),
            DataCell(Text(request.regNo)),
            DataCell(Text(request.docRequested)),
            DataCell(request.requiredDocumentUrl != null
                ? ElevatedButton(
                    onPressed: () {
                      _viewDocument(request.requiredDocumentUrl!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('View'),
                  )
                : const Text('Nil')),
            if (showStatus)
              DataCell(Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      requestController?.acceptRequest(request);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Accept'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _showRejectDialog(context!, requestController!, request);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Reject'),
                  ),
                ],
              )),
            if (showUploadButton)
              DataCell(ElevatedButton(
                onPressed: () {
                  _showUploadDialog(context!, requestController!, request);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Upload'),
              )),
            if (showViewButton)
              DataCell(ElevatedButton(
                onPressed: request.documentUrl != null
                    ? () {
                        _viewDocument(request.documentUrl!);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: request.documentUrl != null ? Colors.green : Colors.grey,
                ),
                child: const Text('View'),
              )),
            if (showReview)
              DataCell(Text(
                request.review ?? '',
                style: const TextStyle(color: Colors.red),
              )),
          ]);
        }).toList(),
      ),
    );
  }

  // Show Upload Dialog
  void _showUploadDialog(
      BuildContext context, RequestController requestController, RequestModel request) {
    final TextEditingController documentUrlController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upload Document'),
          content: TextField(
            controller: documentUrlController,
            decoration: const InputDecoration(
              labelText: 'Enter document URL',
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
                requestController.uploadDocument(request, documentUrlController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Upload'),
            ),
          ],
        );
      },
    );
  }

  // View Document
  void _viewDocument(String documentUrl) {
    // Open the document URL in a browser or a web view
    print('Viewing document: $documentUrl');
  }

  // Show Reject Dialog
  void _showRejectDialog(
      BuildContext context, RequestController requestController, RequestModel request) {
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