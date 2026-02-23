

class SubscriptionRequest {
  String? subscriptionId;
  double? subscriptionRawPrice;
  String? subscriptionPrice;
  String? subscriptionStart;
  String? purchaseID;
  String? platform;

  SubscriptionRequest({
    this.subscriptionId,
    this.subscriptionRawPrice,
    this.subscriptionPrice,
    this.subscriptionStart,
    this.purchaseID,
    this.platform
  });

  factory SubscriptionRequest.fromJson(Map<String, dynamic> json) => SubscriptionRequest(
    subscriptionId: json["subscriptionId"],
    subscriptionRawPrice: json["subscriptionRawPrice"],
    subscriptionPrice: json["subscriptionPrice"],
    subscriptionStart: json["subscriptionStart"],
      purchaseID: json["purchaseID"],
      platform: json["platform"]
  );

  Map<String, dynamic> toJson() => {
    "subscriptionId": subscriptionId,
    "subscriptionRawPrice": subscriptionRawPrice,
    "subscriptionPrice": subscriptionPrice,
    "subscriptionStart": subscriptionStart,
    "purchaseID":purchaseID,
    "platform": platform
  };
}
