class DeleteAccountRequest {
  String? countryCode;
  String? mobile;
  String? otp;
  String? email;
  String? password;
  String? preferredLang;
  String? loginType;
  String? deviceToken;

  DeleteAccountRequest({
    this.countryCode,
    this.mobile,
    this.otp,
    this.email,
    this.password,
    this.preferredLang,
    this.loginType,
    this.deviceToken,
  });

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) => DeleteAccountRequest(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    otp: json["otp"],
    email: json["email"],
    password: json["password"],
    preferredLang: json["preferredLang"],
    loginType: json["loginType"],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (email?.isNotEmpty ?? false) {
      data["email"] = email;
    }
    if (otp?.isNotEmpty ?? false) {
      data["otp"] = otp;
    }
    if (preferredLang?.isNotEmpty ?? false) {
      data["preferredLang"] = preferredLang;
    }
    if (password?.isNotEmpty ?? false) {
      data["password"] = password;
    }
    if (countryCode?.isNotEmpty ?? false) {
      data["countryCode"] = countryCode;
    }
    if (mobile?.isNotEmpty ?? false) {
      data["mobile"] = mobile;
    }
    if (loginType?.isNotEmpty ?? false) {
      data["loginType"] = loginType;
    }
    if (deviceToken?.isNotEmpty ?? false) {
      data["device_token"] = deviceToken;
    }

    return data;
  }
  // Map<String, dynamic> toJson() => {
  //   "countryCode": countryCode,
  //   "mobile": mobile,
  //   "otp": otp,
  //   "email": email,
  //   "password": password,
  //   "preferredLang": preferredLang,
  //   "loginType": loginType,
  //   "device_token": deviceToken,
  // };
}
