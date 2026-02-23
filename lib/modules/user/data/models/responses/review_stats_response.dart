class ReviewStatsResponse {
  int? status;
  String? message;
  Data? data;

  ReviewStatsResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ReviewStatsResponse.fromJson(Map<String, dynamic> json) => ReviewStatsResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? searchedHistoryByUserTotalCounts;
  int? searchedHistoryByUserResultTotalCounts;
  int? myTotalReviewCounts;
  int? searchedHistoryTotalCounts;
  int? searchedHistoryResultTotalCount;
  int? platformTotalReviewCounts;
  List<TotalFlagCount>? totalPlatformFlagCounts;
  List<TotalFlagCount>? totalUserFlagCounts;

  Data({
    this.searchedHistoryByUserTotalCounts,
    this.searchedHistoryByUserResultTotalCounts,
    this.myTotalReviewCounts,
    this.searchedHistoryTotalCounts,
    this.searchedHistoryResultTotalCount,
    this.platformTotalReviewCounts,
    this.totalPlatformFlagCounts,
    this.totalUserFlagCounts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    searchedHistoryByUserTotalCounts: json["searchedHistoryByUserTotalCounts"],
    searchedHistoryByUserResultTotalCounts: json["searchedHistoryByUserResultTotalCounts"],
    myTotalReviewCounts: json["myTotalReviewCounts"],
    searchedHistoryTotalCounts: json["searchedHistoryTotalCounts"],
    searchedHistoryResultTotalCount: json["searchedHistoryResultTotalCount"],
    platformTotalReviewCounts: json["platformTotalReviewCounts"],
    totalPlatformFlagCounts: json["totalPlatformFlagCounts"] == null ? [] : List<TotalFlagCount>.from(json["totalPlatformFlagCounts"]!.map((x) => TotalFlagCount.fromJson(x))),
    totalUserFlagCounts: json["totalUserFlagCounts"] == null ? [] : List<TotalFlagCount>.from(json["totalUserFlagCounts"]!.map((x) => TotalFlagCount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "searchedHistoryByUserTotalCounts": searchedHistoryByUserTotalCounts,
    "searchedHistoryByUserResultTotalCounts": searchedHistoryByUserResultTotalCounts,
    "myTotalReviewCounts": myTotalReviewCounts,
    "searchedHistoryTotalCounts": searchedHistoryTotalCounts,
    "searchedHistoryResultTotalCount": searchedHistoryResultTotalCount,
    "platformTotalReviewCounts": platformTotalReviewCounts,
    "totalPlatformFlagCounts": totalPlatformFlagCounts == null ? [] : List<dynamic>.from(totalPlatformFlagCounts!.map((x) => x.toJson())),
    "totalUserFlagCounts": totalUserFlagCounts == null ? [] : List<dynamic>.from(totalUserFlagCounts!.map((x) => x.toJson())),
  };
}

class TotalFlagCount {
  int? id;
  int? count;

  TotalFlagCount({
    this.id,
    this.count,
  });

  factory TotalFlagCount.fromJson(Map<String, dynamic> json) => TotalFlagCount(
    id: json["_id"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "count": count,
  };
}
