import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsModel {
  String? transactionId, reference, userId, propertyId, propertyTitle, userName;

  int? paymentMethod, //(0 = visa , 1 = mastercard)
      serial,
      userRole, // [ 0 = Users , 1 = Owners , 2 = Agents  , 3 = Real Estate Managers ]
      type, // [ 0 = rent , 1 = sale]
      status; // ( 0 = pending, 1 = successful, 2 = unsuccessfuly, 3 = rejected, 4 = canceled)

  double? amount;
  Timestamp? createdDate;

  TransactionsModel(
      this.transactionId,
      this.reference,
      this.userId,
      this.amount,
      this.userName,
      this.paymentMethod,
      this.serial,
      this.type,
      this.status,
      this.createdDate,
      this.userRole,
      this.propertyId,
      this.propertyTitle);
  TransactionsModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'] ?? '';
    reference = json['reference'] ?? '';
    userId = json['userId'] ?? '';
    userName = json['userName'] ?? '';
    paymentMethod = json['paymentMethod'] ?? 0;
    serial = json['serial'] ?? 0;
    type = json['type'] ?? 0;
    userRole = json['userRole'] ?? 0;
    propertyId = json['propertyId'] ?? '';
    propertyTitle = json['propertyTitle'] ?? '';
    status = json['status'] ?? 0;
    createdDate = json['createdDate'];
    if (json['amount'] != null) {
      amount = json['amount'] is double
          ? json['amount']
          : (json['amount'] as int).toDouble();
    } else {
      amount = 0.0;
    }
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (transactionId != null) data['transactionId'] = transactionId;
    if (reference != null) data['reference'] = reference;
    if (userId != null) data['userId'] = userId;
    if (amount != null) data['amount'] = amount;
    if (userName != null) data['userName'] = userName;
    if (paymentMethod != null) data['paymentMethod'] = paymentMethod;
    if (serial != null) data['serial'] = serial;
    if (type != null) data['type'] = type;
    if (status != null) data['status'] = status;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (propertyTitle != null) data['propertyTitle'] = propertyTitle;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (userRole != null) data['userRole'] = userRole;
    return data;
  }
}
