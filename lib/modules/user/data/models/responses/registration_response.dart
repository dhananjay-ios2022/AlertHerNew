class RegistrationResponse {
  int? status;
  String? message;
  Data? data;
  String? token;

  RegistrationResponse({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => RegistrationResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "token": token,
  };
}

class Data {
  User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
  };
}

class User {
  String? id;
  bool? isEmailVerified;
  bool? isDeleted;
  bool? isActive;
  int? otpExpiryTime;
  dynamic subscriptionRawPrice;
  bool? subscriptionStatus;
  DateTime? subscriptionStart;
  DateTime? subscriptionEnd;
  dynamic subscriptionType;
  String? preferredLang;
  String? countryCode;
  String? mobile;
  bool? isMobileVerified;
  dynamic userType;
  dynamic loginType;
  dynamic gender;
  dynamic nationality;
  NotificationPreferences? notificationPreferences;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? referralCode;
  int? v;
  String? email;
  String? username;
  String? subscriptionId;
  String? subscriptionPrice;
  Subscription? subscription;
  String? userId;

  User({
    this.id,
    this.isEmailVerified,
    this.isDeleted,
    this.isActive,
    this.otpExpiryTime,
    this.subscriptionRawPrice,
    this.subscriptionStatus,
    this.subscriptionStart,
    this.subscriptionEnd,
    this.subscriptionType,
    this.preferredLang,
    this.countryCode,
    this.mobile,
    this.isMobileVerified,
    this.userType,
    this.loginType,
    this.gender,
    this.nationality,
    this.notificationPreferences,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
    this.v,
    this.email,
    this.username,
    this.subscriptionId,
    this.subscriptionPrice,
    this.subscription,
    this.userId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    isEmailVerified: json["isEmailVerified"],
    isDeleted: json["isDeleted"],
    isActive: json["isActive"],
    otpExpiryTime: json["otpExpiryTime"],
    subscriptionRawPrice: json["subscriptionRawPrice"],
    subscriptionStatus: json["subscriptionStatus"],
    subscriptionStart: json["subscriptionStart"] == null ? null :DateTime.parse(json["subscriptionStart"]),
    subscriptionEnd: json["subscriptionEnd"] == null ? null : DateTime.parse(json["subscriptionEnd"]),
    subscriptionType: json["subscriptionType"],
    preferredLang: json["preferredLang"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    isMobileVerified: json["isMobileVerified"],
    userType: json["userType"],
    loginType: json["loginType"],
    gender: json["gender"],
    nationality: json["nationality"],
    notificationPreferences: json["notificationPreferences"] == null ? null : NotificationPreferences.fromJson(json["notificationPreferences"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    referralCode: json["referralCode"],
    v: json["__v"],
    email: json["email"],
    username: json["username"],
    subscriptionId: json["subscriptionId"],
    subscriptionPrice: json["subscriptionPrice"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    userId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isEmailVerified": isEmailVerified,
    "isDeleted": isDeleted,
    "isActive": isActive,
    "otpExpiryTime": otpExpiryTime,
    "subscriptionRawPrice": subscriptionRawPrice,
    "subscriptionStatus": subscriptionStatus,
    "subscriptionStart": subscriptionStart?.toIso8601String(),
    "subscriptionEnd": subscriptionEnd?.toIso8601String(),
    "subscriptionType": subscriptionType,
    "preferredLang": preferredLang,
    "countryCode": countryCode,
    "mobile": mobile,
    "isMobileVerified": isMobileVerified,
    "userType": userType,
    "loginType": loginType,
    "gender": gender,
    "nationality": nationality,
    "notificationPreferences": notificationPreferences?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "referralCode": referralCode,
    "__v": v,
    "email": email,
    "username": username,
    "subscriptionId": subscriptionId,
    "subscriptionPrice": subscriptionPrice,
    "subscription": subscription?.toJson(),
    "id": userId,
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
    this.planId,
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
    planId: json["plan_id"]
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
    "plan_id": planId
  };
}