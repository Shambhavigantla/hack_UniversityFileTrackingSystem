// filepath: c:\Users\shamb\vector\models\request_model.dart
class RequestModel {
  String no;
  String name;
  String regNo;
  String docRequested;
  String? requiredDocumentUrl; // URL of the required document
  String? documentUrl; // URL of the uploaded document
  String? review; // Reason for rejection

  RequestModel({
    required this.no,
    required this.name,
    required this.regNo,
    required this.docRequested,
    this.requiredDocumentUrl,
    this.documentUrl,
    this.review,
  });
}