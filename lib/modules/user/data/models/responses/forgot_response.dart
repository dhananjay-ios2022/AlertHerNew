class ForgotResponse {
  int? status;
  bool? message;
  String? data;
  Token? token;

  ForgotResponse({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  factory ForgotResponse.fromJson(Map<String, dynamic> json) => ForgotResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"],
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "token": token?.toJson(),
  };
}

class Token {
  String? id;
  String? username;
  String? email;
  bool? isEmailVerified;
  bool? isDeleted;
  bool? isActive;
  bool? subscriptionStatus;
  dynamic subscriptionStart;
  dynamic subscriptionEnd;
  dynamic subscriptionType;
  bool? cardActivated;
  String? preferredLang;
  String? countryCode;
  String? mobile;
  dynamic userType;
  dynamic loginType;
  String? gender;
  String? nationality;
  NotificationPreferences? notificationPreferences;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;
  int? v;

  Token({
    this.id,
    this.username,
    this.email,
    this.isEmailVerified,
    this.isDeleted,
    this.isActive,
    this.subscriptionStatus,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.subscriptionType,
    this.cardActivated,
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
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    subscriptionStatus: json["subscriptionStatus"],
    subscriptionStart: json["subscriptionStart"],
    subscriptionEnd: json["subscriptionEnd"],
    subscriptionType: json["subscriptionType"],
    cardActivated: json["cardActivated"],
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
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "subscriptionStatus": subscriptionStatus,
    "subscriptionStart": subscriptionStart,
    "subscriptionEnd": subscriptionEnd,
    "subscriptionType": subscriptionType,
    "cardActivated": cardActivated,
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
  };
}

class NotificationPreferences {
  bool? recentLogins;
  bool? leadsGenerated;
  bool? subscriptionExpiry;
  bool? offersAndPromotions;

  NotificationPreferences({
    this.recentLogins,
    this.leadsGenerated,
    this.subscriptionExpiry,
    this.offersAndPromotions,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => NotificationPreferences(
    recentLogins: json["recentLogins"],
    leadsGenerated: json["leadsGenerated"],
    subscriptionExpiry: json["subscriptionExpiry"],
    offersAndPromotions: json["offersAndPromotions"],
  );

  Map<String, dynamic> toJson() => {
    "recentLogins": recentLogins,
    "leadsGenerated": leadsGenerated,
    "subscriptionExpiry": subscriptionExpiry,
    "offersAndPromotions": offersAndPromotions,
  };
}
