// filepath: c:\Users\shamb\vector\controllers\request_controller.dart
import 'package:get/get.dart';
import 'package:vector/MODELS/request_model.dart';

class RequestController extends GetxController {
  // Lists to manage requests
  var currentRequests = <RequestModel>[].obs;
  var pendingRequests = <RequestModel>[].obs;
  var completedRequests = <RequestModel>[].obs;
  var rejectedRequests = <RequestModel>[].obs;

  // Add initial data to currentRequests
  @override
  void onInit() {
    super.onInit();
    currentRequests.addAll([
      RequestModel(no: '1', name: 'John', regNo: '12345', docRequested: 'TC'),
      RequestModel(no: '2', name: 'Jane', regNo: '67890', docRequested: 'ID Card (Lost)'),
    ]);
  }

  // Accept a request
  void acceptRequest(RequestModel request) {
    currentRequests.remove(request);
    pendingRequests.add(request);
  }

  // Reject a request
  void rejectRequest(RequestModel request, String review) {
    currentRequests.remove(request);
    request.review = review;
    rejectedRequests.add(request);
  }

  // Upload a document for a pending request
  void uploadDocument(RequestModel request, String documentUrl) {
    // Update the document URL for the request
    request.documentUrl = documentUrl;

    // Move the request to the completedRequests list
    pendingRequests.remove(request);
    completedRequests.add(request);
  }
}