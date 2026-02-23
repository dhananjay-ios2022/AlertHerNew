class GetProfileResponse {
  int? status;
  String? message;
  Data? data;

  GetProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
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
  String? id;
  bool? isEmailVerified;
  bool? isDeleted;
  bool? isActive;
  String? otp;
  int? otpExpiryTime;
  bool? subscriptionStatus;
  dynamic subscriptionStart;
  dynamic subscriptionEnd;
  dynamic subscriptionType;
  String? preferredLang;
  String? countryCode;
  String? mobile;
  dynamic userType;
  dynamic loginType;
  dynamic gender;
  dynamic nationality;
  NotificationPreferences? notificationPreferences;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;
  int? v;
  bool? isMobileVerified;
  String? email;
  String? username;

  Data({
    this.id,
    this.isEmailVerified,
    this.isDeleted,
    this.isActive,
    this.otp,
    this.otpExpiryTime,
    this.subscriptionStatus,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.subscriptionType,
    this.preferredLang,
    this.countryCode,
    this.mobile,
    this.userType,
    this.loginType,
    this.gender,
    this.nationality,
    this.notificationPreferences,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
    this.v,
    this.isMobileVerified,
    this.email,
    this.username,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    isEmailVerified: json["isEmailVerified"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    otp: json["otp"],
    otpExpiryTime: json["otpExpiryTime"],
    subscriptionStatus: json["subscriptionStatus"],
    subscriptionStart: json["subscriptionStart"],
    subscriptionEnd: json["subscriptionEnd"],
    subscriptionType: json["subscriptionType"],
    preferredLang: json["preferredLang"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    userType: json["userType"],
    loginType: json["loginType"],
    gender: json["gender"],
    nationality: json["nationality"],
    notificationPreferences: json["notificationPreferences"] == null ? null : NotificationPreferences.fromJson(json["notificationPreferences"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    referralCode: json["referralCode"],
    v: json["__v"],
    isMobileVerified: json["isMobileVerified"],
    email: json["email"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isEmailVerified": isEmailVerified,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "otp": otp,
    "otpExpiryTime": otpExpiryTime,
    "subscriptionStatus": subscriptionStatus,
    "subscriptionStart": subscriptionStart,
    "subscriptionEnd": subscriptionEnd,
    "subscriptionType": subscriptionType,
    "preferredLang": preferredLang,
    "countryCode": countryCode,
    "mobile": mobile,
    "userType": userType,
    "loginType": loginType,
    "gender": gender,
    "nationality": nationality,
    "notificationPreferences": notificationPreferences?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "referralCode": referralCode,
    "__v": v,
    "isMobileVerified": isMobileVerified,
    "email": email,
    "username": username,
  };
}

class NotificationPreferences {
  bool? recentLogins;
  bool? subscriptionExpiry;
  bool? offersAndPromotions;

  NotificationPreferences({
    this.recentLogins,
    this.subscriptionExpiry,
    this.offersAndPromotions,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => NotificationPreferences(
    recentLogins: json["recentLogins"],
    subscriptionExpiry: json["subscriptionExpiry"],
    offersAndPromotions: json["offersAndPromotions"],
  );

  Map<String, dynamic> toJson() => {
    "recentLogins": recentLogins,
    "subscriptionExpiry": subscriptionExpiry,
    "offersAndPromotions": offersAndPromotions,
  };
}
