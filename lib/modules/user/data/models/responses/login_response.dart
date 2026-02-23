class LoginResponse {
  int? status;
  String? message;
  LoginData? data;
  String? token;

  LoginResponse({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "token": token,
  };

  @override
  String toString() {
    return '''
LoginResponse:
  Status: $status
  Message: $message
  Token: $token
  Data: ${data?.toString() ?? "null"}
    ''';
  }
}

class LoginData {
  String? countryCode;
  dynamic gender;
  dynamic nationality;
  String? id;
  String? username;
  String? email;
  bool? isEmailVerified;
  bool? isMobileVerified;
  bool? isDeleted;
  bool? isActive;
  bool? subscriptionStatus;
  DateTime? subscriptionStart;
  DateTime? subscriptionEnd;
  String? subscriptionId;
  String? subscriptionPrice;
  String? fcmToken;
  Subscription? subscription;
  dynamic subscriptionRawPrice;
  //dynamic subscriptionType;
  bool? cardActivated;
  String? preferredLang;
  String? mobile;
  dynamic userType;
  String? loginType;
  NotificationPreferences? notificationPreferences;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;
  int? v;
  String? otp;
  String? deviceToken;

  LoginData({
    this.countryCode,
    this.gender,
    this.nationality,
    this.id,
    this.username,
    this.email,
    this.isEmailVerified,
    this.isMobileVerified,
    this.isDeleted,
    this.isActive,
    this.subscriptionStatus,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.subscriptionId,
    this.subscriptionPrice,
    this.fcmToken,
    this.subscription,
    this.subscriptionRawPrice,
   // this.subscriptionType,
    this.cardActivated,
    this.preferredLang,
    this.mobile,
    this.userType,
    this.loginType,
    this.notificationPreferences,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
    this.v,
    this.otp,
    this.deviceToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    countryCode: json["countryCode"],
    gender: json["gender"],
    nationality: json["nationality"],
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    isMobileVerified: json["isMobileVerified"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    subscriptionStatus: json["subscriptionStatus"],
    subscriptionStart: json["subscriptionStart"] == null ? null :DateTime.parse(json["subscriptionStart"]),
    subscriptionEnd: json["subscriptionEnd"] == null ? null : DateTime.parse(json["subscriptionEnd"]),
    subscriptionId: json["subscriptionId"],
    subscriptionPrice: json["subscriptionPrice"],
    fcmToken: json["fcm_token"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
   subscriptionRawPrice: json["subscriptionRawPrice"],
   // subscriptionType: json["subscriptionType"],
    cardActivated: json["cardActivated"],
    preferredLang: json["preferredLang"],
    mobile: json["mobile"],
    userType: json["userType"],
    loginType: json["loginType"],
    notificationPreferences: json["notificationPreferences"] == null
        ? null
        : NotificationPreferences.fromJson(json["notificationPreferences"]),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    referralCode: json["referralCode"],
    v: json["__v"],
    otp: json["otp"],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "gender": gender,
    "nationality": nationality,
    "_id": id,
    "username": username,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "isMobileVerified": isMobileVerified,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "subscriptionStatus": subscriptionStatus,
    "subscriptionStart": subscriptionStart?.toIso8601String(),
    "subscriptionEnd": subscriptionEnd?.toIso8601String(),
    "subscriptionId": subscriptionId,
    "subscriptionPrice": subscriptionPrice,
    "fcm_token": fcmToken,
    "subscription": subscription?.toJson(),
    "subscriptionRawPrice": subscriptionRawPrice,
    //"subscriptionType": subscriptionType,
    "cardActivated": cardActivated,
    "preferredLang": preferredLang,
    "mobile": mobile,
    "userType": userType,
    "loginType": loginType,
    "notificationPreferences": notificationPreferences?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "referralCode": referralCode,
    "__v": v,
    "otp": otp,
    "device_token": deviceToken,
  };

  @override
  String toString() {
    return '''
Data:
  ID: $id
  Username: $username
  Email: $email
  Mobile: $mobile
  Gender: $gender
  Nationality: $nationality
  Is Email Verified: $isEmailVerified
  Is Mobile Verified: $isMobileVerified
  Is Deleted: $isDeleted
  Is Active: $isActive
  Subscription Status: $subscriptionStatus
  Card Activated: $cardActivated
  Preferred Language: $preferredLang
  Login Type: $loginType
  Notification Preferences: ${notificationPreferences?.toString() ?? "null"}
  Created At: $createdAt
  Updated At: $updatedAt
  Referral Code: $referralCode
    ''';
  }
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

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      NotificationPreferences(
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

  @override
  String toString() {
    return '''
NotificationPreferences:
  Recent Logins: $recentLogins
  Leads Generated: $leadsGenerated
  Subscription Expiry: $subscriptionExpiry
  Offers and Promotions: $offersAndPromotions
    ''';
  }
}

class Subscription {
  String? id;
  String? subscriptionId;
  String? title;
  String? description;
  String? currencyCode;
  String? currencySymbol;
  int? duration;
  String? price;
  dynamic rawPrice;
  bool? isActive;
  bool? isDeleted;
  String? durationType;
  String? planId;

  Subscription({
    this.id,
    this.subscriptionId,
    this.title,
    this.description,
    this.currencyCode,
    this.currencySymbol,
    this.duration,
    this.price,
    this.rawPrice,
    this.isActive,
    this.isDeleted,
    this.durationType,
    this.planId
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["_id"],
    subscriptionId: json["id"],
    title: json["title"],
    description: json["description"],
    currencyCode: json["currencyCode"],
    currencySymbol: json["currencySymbol"],
    duration: json["duration"],
    price: json["price"],
    rawPrice: json["rawPrice"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    durationType: json["durationType"],
    planId: json["plan_id"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "id": subscriptionId,
    "title": title,
    "description": description,
    "currencyCode": currencyCode,
    "currencySymbol": currencySymbol,
    "duration": duration,
    "price": price,
    "rawPrice": rawPrice,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "durationType": durationType,
    "plan_id": planId,

  };
}
