import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/api/reviews_api.dart';
import 'package:next_location/data/model/property_model.dart';
import 'package:next_location/data/model/review_model.dart';

class ReviewsRepository {
  Future<bool?> placePropertyReview(
      PropertyModel propertyModel, ReviewModel reviewModel) async {
    return await ReviewsApi().placePropertyReview(propertyModel, reviewModel);
  }

  Future<ReviewModel?> getReviewById(String id) async {
    ReviewModel? reviewModel;

    DocumentSnapshot? documentSnapshot = await ReviewsApi().getReviewById(id);
    if (documentSnapshot != null && documentSnapshot.exists) {
      reviewModel =
          ReviewModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
    return reviewModel;
  }

  // sort options [ 'createdDate', 'userName', 'totalReviewRate']
  // search filters options [ 'userName',  'userName']
  Future<List<ReviewModel>> getPropertyReviews(
      String propertyId,
      ReviewModel? lastModel,
      String sort,
      bool descending,
      String searchText,
      String searchFilter) async {
    List<ReviewModel> reviewsList = [];
    QuerySnapshot? querySnapshot = await ReviewsApi().getPropertyReviews(
        propertyId, lastModel, sort, descending, searchText, searchFilter);
    if (querySnapshot != null && querySnapshot.docs.isNotEmpty) {
      if (querySnapshot.docs.isNotEmpty) {
        reviewsList = querySnapshot.docs
            .map((e) => ReviewModel.fromJson(e.data() as Map<String, dynamic>))
            .toList();
      }
    }
    return reviewsList;
  }

  Future<int> getPropertyReviewsCount(String propertyId) async {
    return await ReviewsApi().getPropertyReviewsCount(propertyId);
  }

  Future<bool> requestReviewDeletion(ReviewModel reviewModel) async {
    return await ReviewsApi().requestReviewDeletion(reviewModel);
  }
}
