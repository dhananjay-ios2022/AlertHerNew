class SearchResponse {
  int? status;
  String? message;
  List<SearchResults>? data;

  SearchResponse({
    this.status,
    this.message,
    this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SearchResults>.from(json["data"]!.map((x) => SearchResults.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SearchResults {
  String? countryCode;
  String? mobile;
  int? totalCount;
  String? lastReviewedName;
  int? maxFlag;

  SearchResults({
    this.countryCode,
    this.mobile,
    this.totalCount,
    this.lastReviewedName,
    this.maxFlag,
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    totalCount: json["totalCount"],
    lastReviewedName: json["lastReviewedName"],
    maxFlag: json["maxFlag"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
    "totalCount": totalCount,
    "lastReviewedName": lastReviewedName,
    "maxFlag": maxFlag,
  };
}
