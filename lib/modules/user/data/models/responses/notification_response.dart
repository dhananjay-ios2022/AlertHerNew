class NotificationResponse {
  int? status;
  String? message;
  List<DatumNoti>? data;

  NotificationResponse({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DatumNoti>.from(json["data"]!.map((x) => DatumNoti.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DatumNoti {
  List<TotalDocument>? totalDocuments;
  List<NotificationItem>? notification;

  DatumNoti({
    this.totalDocuments,
    this.notification,
  });

  factory DatumNoti.fromJson(Map<String, dynamic> json) => DatumNoti(
    totalDocuments: json["totalDocuments"] == null ? [] : List<TotalDocument>.from(json["totalDocuments"]!.map((x) => TotalDocument.fromJson(x))),
    notification: json["notification"] == null ? [] : List<NotificationItem>.from(json["notification"]!.map((x) => NotificationItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalDocuments": totalDocuments == null ? [] : List<dynamic>.from(totalDocuments!.map((x) => x.toJson())),
    "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
  };
}

class NotificationItem {
  String? id;
  String? name;
  bool? isRead;
  String? description;
  String? userId;
  int? notifyBy;
  String? reason;
  int? type;
  String? reviewId;
  bool? isSent;
  String? countryCode;
  String? mobile;
  String? createdAt;
  DateTime? updatedAt;
  int? v;

  NotificationItem({
    this.id,
    this.name,
    this.isRead,
    this.description,
    this.userId,
    this.notifyBy,
    this.reason,
    this.type,
    this.reviewId,
    this.isSent,
    this.countryCode,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
    id: json["_id"],
    name: json["name"],
    isRead: json["isRead"],
    description: json["description"],
    userId: json["userId"],
    notifyBy: json["notifyBy"],
    reason: json["reason"],
    type: json["type"],
    reviewId: json["reviewID"],
    isSent: json["isSent"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    createdAt: json["createdAt"] ,
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "isRead": isRead,
    "description": description,
    "userId": userId,
    "notifyBy": notifyBy,
    "reason": reason,
    "type": type,
    "reviewID": reviewId,
    "isSent": isSent,
    "countryCode": countryCode,
    "mobile": mobile,
    "createdAt": createdAt,
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class TotalDocument {
  int? count;

  TotalDocument({
    this.count,
  });

  factory TotalDocument.fromJson(Map<String, dynamic> json) => TotalDocument(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
