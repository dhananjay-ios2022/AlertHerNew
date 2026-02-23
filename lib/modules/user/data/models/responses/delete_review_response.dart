// To parse this JSON data, do
//
//     final deleteReviewResponse = deleteReviewResponseFromJson(jsonString);

import 'dart:convert';

DeleteReviewResponse deleteReviewResponseFromJson(String str) => DeleteReviewResponse.fromJson(json.decode(str));

String deleteReviewResponseToJson(DeleteReviewResponse data) => json.encode(data.toJson());

class DeleteReviewResponse {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  DeleteReviewResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory DeleteReviewResponse.fromJson(Map<String, dynamic> json) => DeleteReviewResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  bool? acknowledged;
  int? deletedCount;

  Data({
    this.acknowledged,
    this.deletedCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    acknowledged: json["acknowledged"],
    deletedCount: json["deletedCount"],
  );

  Map<String, dynamic> toJson() => {
    "acknowledged": acknowledged,
    "deletedCount": deletedCount,
  };
}
