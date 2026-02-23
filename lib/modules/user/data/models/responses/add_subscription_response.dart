class GetSubscriptionResponse {
  int? status;
  String? message;
  Data? data;

  GetSubscriptionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetSubscriptionResponse.fromJson(Map<String, dynamic> json) => GetSubscriptionResponse(
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
  String? countryCode;
  DateTime? createdAt;
  String? email;
  dynamic gender;
  bool? isActive;
  bool? isDeleted;
  bool? isEmailVerified;
  bool? isMobileVerified;
  dynamic loginType;
  String? mobile;
  dynamic nationality;
  String? preferredLang;
  String? referralCode;
  DateTime? subscriptionEnd;
  double? subscriptionRawPrice;
  DateTime? subscriptionStart;
  bool? subscriptionStatus;
  DateTime? updatedAt;
  String? username;
  String? subscriptionId;
  String? subscriptionPrice;
  Subscription? subscription;
  String? dataId;

  Data({
    this.id,
    this.countryCode,
    this.createdAt,
    this.email,
    this.gender,
    this.isActive,
    this.isDeleted,
    this.isEmailVerified,
    this.isMobileVerified,
    this.loginType,
    this.mobile,
    this.nationality,
    this.preferredLang,
    this.referralCode,
    this.subscriptionEnd,
    this.subscriptionRawPrice,
    this.subscriptionStart,
    this.subscriptionStatus,
    this.updatedAt,
    this.username,
    this.subscriptionId,
    this.subscriptionPrice,
    this.subscription,
    this.dataId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    countryCode: json["countryCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    email: json["email"],
    gender: json["gender"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    isEmailVerified: json["isEmailVerified"],
    isMobileVerified: json["isMobileVerified"],
    loginType: json["loginType"],
    mobile: json["mobile"],
    nationality: json["nationality"],
    preferredLang: json["preferredLang"],
    referralCode: json["referralCode"],
    subscriptionEnd: json["subscriptionEnd"] == null ? null : DateTime.parse(json["subscriptionEnd"]),
    subscriptionRawPrice: json["subscriptionRawPrice"]?.toDouble(),
    subscriptionStart: json["subscriptionStart"] == null ? null : DateTime.parse(json["subscriptionStart"]),
    subscriptionStatus: json["subscriptionStatus"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    username: json["username"],
    subscriptionId: json["subscriptionId"],
    subscriptionPrice: json["subscriptionPrice"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
    dataId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryCode": countryCode,
    "createdAt": createdAt?.toIso8601String(),
    "email": email,
    "gender": gender,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "isEmailVerified": isEmailVerified,
    "isMobileVerified": isMobileVerified,
    "loginType": loginType,
    "mobile": mobile,
    "nationality": nationality,
    "preferredLang": preferredLang,
    "referralCode": referralCode,
    "subscriptionEnd": subscriptionEnd?.toIso8601String(),
    "subscriptionRawPrice": subscriptionRawPrice,
    "subscriptionStart": subscriptionStart?.toIso8601String(),
    "subscriptionStatus": subscriptionStatus,
    "updatedAt": updatedAt?.toIso8601String(),
    "username": username,
    "subscriptionId": subscriptionId,
    "subscriptionPrice": subscriptionPrice,
    "subscription": subscription?.toJson(),
    "id": dataId,
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
  double? rawPrice;
  int? discount;
  String? discountType;
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
    this.discount,
    this.discountType,
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
    rawPrice: json["rawPrice"]?.toDouble(),
    discount: json["discount"],
    discountType: json["discountType"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    durationType: json["durationType"],
    planId: json["planId"]
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
    "discount": discount,
    "discountType": discountType,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "durationType": durationType,
    "planId": planId,
  };
}
