class ReviewHistoryResponse {
  int? status;
  String? message;
  ReviewData? data;

  ReviewHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ReviewHistoryResponse.fromJson(Map<String, dynamic> json) => ReviewHistoryResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : ReviewData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class ReviewData {
  List<Review>? reviews;
  int? maxFlag;
  String? lastReviewedName;
  int? totalDocuments;
  int? currentPage;
  int? totalPages;

  ReviewData({
    this.reviews,
    this.maxFlag,
    this.lastReviewedName,
    this.totalDocuments,
    this.currentPage,
    this.totalPages,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    reviews: json["Reviews"] == null ? [] : List<Review>.from(json["Reviews"]!.map((x) => Review.fromJson(x))),
    maxFlag: json["maxFlag"],
    lastReviewedName: json["lastReviewedName"],
    totalDocuments: json["totalDocuments"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "Reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "maxFlag": maxFlag,
    "lastReviewedName": lastReviewedName,
    "totalDocuments": totalDocuments,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class Review {
  String? id;
  String? countryCode;
  String? mobile;
  int? flag;
  String? clientName;
  String? description;
  String? reviewedBy;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  bool? isEditable;
  bool? isReportable;
  String? reviewerName;
  int? v;

  Review({
    this.id,
    this.countryCode,
    this.mobile,
    this.flag,
    this.clientName,
    this.description,
    this.reviewedBy,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.isEditable,
    this.isReportable,
    this.reviewerName,
    this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    flag: json["flag"],
    clientName: json["clientName"],
    description: json["description"],
    reviewedBy: json["reviewedBy"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    isEditable: json["isEditable"],
    isReportable: json["isReportable"],
    reviewerName: json["reviewerName"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryCode": countryCode,
    "mobile": mobile,
    "flag": flag,
    "clientName": clientName,
    "description": description,
    "reviewedBy": reviewedBy,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "isEditable": isEditable,
    "isReportable": isReportable,
    "reviewerName": reviewerName,
    "__v": v,
  };
}
