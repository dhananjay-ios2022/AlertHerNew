class FcmTokenRequest {
  String? deviceToken;

  FcmTokenRequest({
    this.deviceToken,
  });

  factory FcmTokenRequest.fromJson(Map<String, dynamic> json) => FcmTokenRequest(
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "device_token": deviceToken,
  };
}
