// filepath: c:\Users\shamb\vector\models\request_model.dart
class RequestModel {
  final String no;
  final String name;
  final String regNo;
  final String docRequested;
  String? review; // Optional for rejected requests

  RequestModel({
    required this.no,
    required this.name,
    required this.regNo,
    required this.docRequested,
    this.review,
  });
}