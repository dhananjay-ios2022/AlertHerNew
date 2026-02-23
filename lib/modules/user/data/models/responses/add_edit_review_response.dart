class AddReviewResponse {
  Response? response;

  AddReviewResponse({
    this.response,
  });

  factory AddReviewResponse.fromJson(Map<String, dynamic> json) =>
      AddReviewResponse(
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
    "response": response?.toJson(),
  };

  @override
  String toString() {
    return 'AddEditReviewResponse(response: $response)';
  }
}

class Response {
  int? status;
  String? message;
  Data? data;

  Response({
    this.status,
    this.message,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  String toString() {
    return 'Response(status: $status, message: $message, data: $data)';
  }
}

class Data {
  String? countryCode;
  String? mobile;
  String? flag;
  String? clientName;
  String? description;
  String? reviewedBy;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.countryCode,
    this.mobile,
    this.flag,
    this.clientName,
    this.description,
    this.reviewedBy,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    flag: json["flag"],
    clientName: json["clientName"],
    description: json["description"],
    reviewedBy: json["reviewedBy"],
    id: json["_id"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
    "flag": flag,
    "clientName": clientName,
    "description": description,
    "reviewedBy": reviewedBy,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };

  @override
  String toString() {
    return 'Data(countryCode: $countryCode, mobile: $mobile, flag: $flag, clientName: $clientName, '
        'description: $description, reviewedBy: $reviewedBy, id: $id, '
        'createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }
}
