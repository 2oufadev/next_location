import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/documents_api.dart';
import 'package:next_location/data/model/documents_model.dart';

class DocumentsRepository {
  Future<dynamic> addDocument(DocumentsModel model) async {
    return await DocumentsApi().addDocument(model);
  }

  Future<bool> updateDocument(DocumentsModel model) async {
    var result = await DocumentsApi().updateDocument(model);
    return result;
  }

  Future<DocumentsModel?> getDocumentByID(String id) async {
    DocumentSnapshot? documentSnapshot =
        await DocumentsApi().getDocumentByID(id);

    DocumentsModel? documentsModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      documentsModel = DocumentsModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return documentsModel;
  }

  Future<DocumentsModel?> getDocumentBySerial(
      int serial, bool approvedOnly) async {
    DocumentSnapshot? documentSnapshot =
        await DocumentsApi().getDocumentBySerial(serial, approvedOnly);

    DocumentsModel? documentsModel;

    if (documentSnapshot != null && documentSnapshot.exists) {
      documentsModel = DocumentsModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>);
    }

    return documentsModel;
  }

  Future<List<DocumentsModel>> getUsersDocuments(
      String userId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    List<DocumentsModel> documentsList = [];
    querySnapshot =
        await DocumentsApi().getUsersDocuments(userId, approvedOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      documentsList = querySnapshot.docs
          .map(
            (e) => DocumentsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return documentsList;
  }

  Future<dynamic> getUsersDocumentsCount(
      String submitterId, bool approvedOnly) async {
    return await DocumentsApi()
        .getUsersDocumentsCount(submitterId, approvedOnly);
  }

  Future<List<DocumentsModel>> getPropertyDocuments(
      String propertyId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    List<DocumentsModel> documentsList = [];
    querySnapshot =
        await DocumentsApi().getPropertysDocuments(propertyId, approvedOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      documentsList = querySnapshot.docs
          .map(
            (e) => DocumentsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return documentsList;
  }

  Future<List<DocumentsModel>> getContractsDocuments(
      String contractId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    List<DocumentsModel> documentsList = [];
    querySnapshot =
        await DocumentsApi().getContractsDocuments(contractId, approvedOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      documentsList = querySnapshot.docs
          .map(
            (e) => DocumentsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return documentsList;
  }

  Future<List<DocumentsModel>> getUsersVerificationsDocuments(
      String userId, bool approvedOnly) async {
    QuerySnapshot? querySnapshot;
    List<DocumentsModel> documentsList = [];
    querySnapshot = await DocumentsApi()
        .getUsersVerificationsDocuments(userId, approvedOnly);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      documentsList = querySnapshot.docs
          .map(
            (e) => DocumentsModel.fromJson(e.data() as Map<String, dynamic>),
          )
          .toList();
    }
    return documentsList;
  }
}
