class VerifyOtpRequest {
  String? countryCode;
  String? mobile;
  int? otp;
  String? preferredLang;

  VerifyOtpRequest({
    this.countryCode,
    this.mobile,
    this.otp,
    this.preferredLang,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) => VerifyOtpRequest(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    otp: json["otp"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
    "otp": otp,
    "preferredLang": preferredLang,
  };
}
