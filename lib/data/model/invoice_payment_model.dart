class InvoicePaymentModel {
  String? title, titleAr;
  double? amount;

  InvoicePaymentModel(this.title, this.titleAr, this.amount);

  InvoicePaymentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    titleAr = json['titleAr'] ?? '';
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
    if (title != null) data['title'] = title;
    if (titleAr != null) data['titleAr'] = titleAr;
    if (amount != null) data['amount'] = amount;

    return data;
  }
}
