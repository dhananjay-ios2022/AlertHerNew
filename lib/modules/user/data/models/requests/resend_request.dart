class ResendRequest {
  String? countryCode;
  String? mobile;
  String? preferredLang;

  ResendRequest({
    this.countryCode,
    this.mobile,
    this.preferredLang,
  });

  factory ResendRequest.fromJson(Map<String, dynamic> json) => ResendRequest(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
    "preferredLang": preferredLang,
  };
}
