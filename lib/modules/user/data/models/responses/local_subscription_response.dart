
class LocalSubscriptionResponse {
  bool? subscriptionStatus;
  String? planId;
  String? title;
  String? description;
  String? currencyCode;
  String? currencySymbol;
  int? duration;
  String? price;
  dynamic rawPrice;
  String? durationType;
  DateTime? subscriptionStart;
  DateTime? subscriptionEnd;

  LocalSubscriptionResponse({
    this.subscriptionStatus,
    this.planId,
    this.title,
    this.description,
    this.currencyCode,
    this.currencySymbol,
    this.duration,
    this.price,
    this.rawPrice,
    this.durationType,
    this.subscriptionStart,
    this.subscriptionEnd
  });

  factory LocalSubscriptionResponse.fromJson(Map<String, dynamic> json) => LocalSubscriptionResponse(
      subscriptionStatus: json["subscriptionStatus"],
    planId: json["planId"],
      title: json["title"],
      description: json["description"],
      currencyCode: json["currencyCode"],
      currencySymbol: json["currencySymbol"],
      duration: json["duration"],
      price: json["price"],
      rawPrice: json["rawPrice"],
      durationType: json["durationType"],
    subscriptionStart: json["subscriptionStart"] == null ? null :DateTime.parse(json["subscriptionStart"]),
    subscriptionEnd: json["subscriptionEnd"] == null ? null : DateTime.parse(json["subscriptionEnd"]),
  );

  Map<String, dynamic> toJson() => {
    "subscriptionStatus": subscriptionStatus,
    "planId": planId,
    "title": title,
    "description": description,
    "currencyCode": currencyCode,
    "currencySymbol": currencySymbol,
    "duration": duration,
    "price": price,
    "rawPrice": rawPrice,
    "durationType": durationType,
    "subscriptionStart": subscriptionStart?.toIso8601String(),
    "subscriptionEnd": subscriptionEnd?.toIso8601String(),
  };
}