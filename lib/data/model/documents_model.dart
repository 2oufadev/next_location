import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentsModel {
  Uint8List? file;
  String? documentId, title, url, fileType, reference, submitterId;
  int? serial;
  int? status; // 0 = pending , 1 = approved, 2 = rejected, 3 = deleted
  Timestamp? createdDate;
  int?
      documentType; // 0 = propertyDocument, 1= contractDocument, 2 = userVerification
  DocumentsModel(
      this.createdDate,
      this.documentId,
      this.serial,
      this.submitterId,
      this.fileType,
      this.status,
      this.reference,
      this.title,
      this.url,
      this.file,
      this.documentType);
  DocumentsModel.fromJson(Map<String, dynamic> json) {
    documentId = json['documentId'] ?? '';
    reference = json['reference'] ?? '';
    serial = json['serial'] ?? 0;
    submitterId = json['submitterId'] ?? '';
    fileType = json['fileType'] ?? '';
    documentType = json['documentType'] ?? 0;
    status = json['status'] ?? 0;
    title = json['title'] ?? '';
    url = json['url'] ?? '';
    createdDate = json['createdDate'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (documentId != null) data['documentId'] = documentId;
    if (reference != null) data['reference'] = reference;
    if (serial != null) data['serial'] = serial;
    if (submitterId != null) data['submitterId'] = submitterId;
    if (fileType != null) data['fileType'] = fileType;
    if (documentType != null) data['documentType'] = documentType;
    if (status != null) data['status'] = status;
    if (title != null) data['title'] = title;
    if (url != null) data['url'] = url;
    if (createdDate != null) data['createdDate'] = createdDate;
    return data;
  }
}
