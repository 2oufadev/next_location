class ReviewItemModel {
  String? title, titleAr;
  double? rate;

  ReviewItemModel(this.title, this.titleAr, this.rate);
  ReviewItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';

    if (json['rate'] != null) {
      rate = json['rate'] is double
          ? json['rate']
          : (json['rate'] as int).toDouble();
    } else {
      rate = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (rate != null) data['rate'] = rate;
    return data;
  }
}
