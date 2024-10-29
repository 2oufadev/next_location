import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/invoices_api.dart';
import 'package:next_location/data/model/invoice_model.dart';

class InvoicesRepository {
  Future<dynamic> addInvoice(InvoiceModel model) async {
    return await InvoicesApi().addInvoice(model);
  }

  Future<bool> updateInvoice(InvoiceModel invoiceModel) async {
    var result = await InvoicesApi().updateInvoice(invoiceModel);
    return result;
  }

  Future<InvoiceModel?> getInvoiceByID(String id) async {
    DocumentSnapshot? documentSnapshot = await InvoicesApi().getInvoiceByID(id);

    InvoiceModel? invoiceModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      invoiceModel = InvoiceModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return invoiceModel;
  }

  Future<InvoiceModel?> getInvoiceBySerial(
      int serial, bool approvedOnly) async {
    DocumentSnapshot? documentSnapshot =
        await InvoicesApi().getInvoiceBySerial(serial, approvedOnly);

    InvoiceModel? invoiceModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      invoiceModel = InvoiceModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return invoiceModel;
  }

  Future<List<InvoiceModel>> getUsersInvoices(
      String id, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    List<InvoiceModel> invoicesList = [];
    querySnapshot = await InvoicesApi().getUsersInvoices(id, approvedOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      invoicesList = querySnapshot.docs
          .map(
            (e) => InvoiceModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return invoicesList;
  }

  Future<dynamic> getUsersInvoicesCount(
      String userId, bool approvedOnly) async {
    return await InvoicesApi().getUsersInvoicesCount(userId, approvedOnly);
  }
}
