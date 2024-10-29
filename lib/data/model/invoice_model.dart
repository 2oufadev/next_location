import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/invoice_payment_model.dart';

class InvoiceModel {
  String? invoiceId, propertyId, userId;
  int? serial;
  int? status; // 0 = pending , 1 = approved, 2 = rejected, 3 = deleted
  bool? paid;
  double? total;
  Timestamp? issuedDate, dueDate;
  List<InvoicePaymentModel>? payments;
  List<InvoicePaymentModel>? taxes;

  InvoiceModel(
      this.invoiceId,
      this.propertyId,
      this.userId,
      this.issuedDate,
      this.dueDate,
      this.serial,
      this.status,
      this.payments,
      this.taxes,
      this.total,
      this.paid);

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoiceId'] ?? '';
    propertyId = json['propertyId'] ?? '';
    userId = json['userId'] ?? '';
    issuedDate = json['issuedDate'];
    dueDate = json['dueDate'];
    serial = json['serial'] ?? 0;
    status = json['status'] ?? 0;
    paid = json['paid'] ?? false;
    if (json['total'] != null) {
      total = json['total'] is double
          ? json['total']
          : (json['total'] as int).toDouble();
    } else {
      total = 0.0;
    }

    if (json['payments'] != null) {
      List list = json['payments'];
      payments = list
          .map((e) => InvoicePaymentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      payments = [];
    }

    if (json['taxes'] != null) {
      List list = json['taxes'];
      taxes = list
          .map((e) => InvoicePaymentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      taxes = [];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (invoiceId != null) data['invoiceId'] = invoiceId;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (userId != null) data['userId'] = userId;
    if (issuedDate != null) data['issuedDate'];
    if (dueDate != null) data['dueDate'] = dueDate;
    if (serial != null) data['serial'] = serial;
    if (status != null) data['status'] = status;
    if (total != null) data['total'] = total;
    if (paid != null) data['paid'] = paid;
    if (payments != null) {
      data['payments'] = payments!.map((e) => e.toJson()).toList();
    }
    if (taxes != null) {
      data['taxes'] = taxes!.map((e) => e.toJson());
    }
    return data;
  }
}
