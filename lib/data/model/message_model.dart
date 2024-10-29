import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? referenceId, senderId, messageId, message;
  int?
      type; // [ 0 = message, 1 = image, 2 = request visit, 3 = approve visit, 4 = request offer, 5 = approve request ]
  Timestamp? createdDate;
  MessageModel(this.referenceId, this.type, this.senderId, this.message,
      this.createdDate, this.messageId);

  MessageModel.fromJson(Map<String, dynamic> json) {
    referenceId = json['referenceId'] ?? '';
    type = json['type'] ?? 0;
    senderId = json['senderId'] ?? '';
    message = json['message'] ?? '';
    type = json['type'] ?? 0;
    createdDate = json['createdDate'];
    messageId = json['messageId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (referenceId != null) data['referenceId'] = referenceId;
    if (type != null) data['type'] = type;
    if (senderId != null) data['senderId'] = senderId;
    if (message != null) data['message'] = message;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (messageId != null) data['messageId'] = messageId;
    if (type != null) data['type'] = type;

    return data;
  }
}
