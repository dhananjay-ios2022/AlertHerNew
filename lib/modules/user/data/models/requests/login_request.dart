class LoginRequest {
  String? email;
  String? preferredLang;
  String? password;
  String? countryCode;
  String? mobile;
  String? loginType;
  String? deviceToken;

  LoginRequest({
    this.email,
    this.preferredLang,
    this.password,
    this.countryCode,
    this.mobile,
    this.loginType,
    this.deviceToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    email: json["email"],
    preferredLang: json["preferredLang"],
    password: json["password"],
    countryCode: json["countryCode"],
    mobile: json["mobile"],
    loginType: json["loginType"],
    deviceToken: json["device_token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "preferredLang": preferredLang,
    "password": password,
    "countryCode": countryCode,
    "mobile": mobile,
    "loginType": loginType,
    "device_token": deviceToken,
  };

  @override
  String toString() {
    return 'LoginRequest('
        'email: $email, '
        'preferredLang: $preferredLang, '
        'password: $password, '
        'countryCode: $countryCode, '
        'mobile: $mobile, '
        'loginType: $loginType, '
        'deviceToken: $deviceToken)';
  }
}
