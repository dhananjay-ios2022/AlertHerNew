class ReportRequest {
  String? reason;
  String? reportedUserId;
  String? reportedReviewId;
  int? reportType;

  ReportRequest({
    this.reason,
    this.reportedUserId,
    this.reportedReviewId,
    this.reportType,
  });

  factory ReportRequest.fromJson(Map<String, dynamic> json) => ReportRequest(
    reason: json["reason"],
    reportedUserId: json["reportedUserId"],
    reportedReviewId: json["reportedReviewId"],
    reportType: json["reportType"],
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
    "reportedUserId": reportedUserId,
    "reportedReviewId": reportedReviewId,
    "reportType": reportType,
  };
}
