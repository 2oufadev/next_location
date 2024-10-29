import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:next_location/data/model/review_item_model.dart';

class ReviewModel {
  String? reviewId, reviewComment, propertyId, userId, userName, userImg;
  Timestamp? createdDate;
  int?
      status; // [0 = pending, 1 = approved, 2 = rejected, 3 = deleted, 4 = requested deletion]
  double? totalReviewRate;
  List<ReviewItemModel>? reviewItems;

  ReviewModel(
      this.reviewId,
      this.reviewComment,
      this.status,
      this.propertyId,
      this.userId,
      this.userName,
      this.userImg,
      this.createdDate,
      this.totalReviewRate,
      this.reviewItems);

  ReviewModel.fromJson(Map<String, dynamic> json) {
    reviewId = json['reviewId'] ?? '';
    reviewComment = json['reviewComment'] ?? '';
    status = json['status'] ?? 0;
    propertyId = json['propertyId'] ?? '';
    userId = json['userId'] ?? '';
    userName = json['userName'] ?? '';
    userImg = json['userImg'] ?? '';
    if (json['createdDate'] != null) {
      createdDate = json['createdDate'];
    }
    if (json['totalReviewRate'] != null) {
      totalReviewRate = json['totalReviewRate'] is double
          ? json['totalReviewRate']
          : (json['totalReviewRate'] as int).toDouble();
    } else {
      totalReviewRate = 0.0;
    }
    if (json['reviewItems'] != null) {
      List<dynamic> list = json['reviewItems'];
      reviewItems = list
          .map((e) => ReviewItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      reviewItems = [];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (reviewId != null) data['reviewId'] = reviewId;
    if (reviewComment != null) data['reviewComment'] = reviewComment;
    if (status != null) data['status'] = status;
    if (propertyId != null) data['propertyId'] = propertyId;
    if (userId != null) data['userId'] = userId;
    if (userName != null) data['userName'] = userName;
    if (totalReviewRate != null) data['totalReviewRate'] = totalReviewRate;
    if (createdDate != null) data['createdDate'] = createdDate;
    if (userImg != null) data['userImg'] = userImg;
    if (reviewItems != null) {
      data['reviewItems'] = reviewItems!.map((e) => e.toJson()).toList();
    }

    return data;
  }
}
