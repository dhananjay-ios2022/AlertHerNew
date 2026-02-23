class RegistrationRequest {
  //String? username;
  String? email;
  String? mobile;
  String? countryCode;
  String? password;
  var gender;
  var nationality;
  String? preferredLang;
  String? deviceToken;
  String? platform;

  RegistrationRequest({
   // this.username,
    this.email,
    this.mobile,
    this.countryCode,
    this.password,
    this.gender,
    this.nationality,
    this.preferredLang,
    this.deviceToken,
    this.platform,
  });

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) => RegistrationRequest(
  //  username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    countryCode: json["countryCode"],
    password: json["password"],
    gender: json["gender"],
    nationality: json["nationality"],
    preferredLang: json["preferredLang"],
    deviceToken: json["device_token"],
    platform: json["platform"],
  );

  Map<String, dynamic> toJson() => {
   // "username": username,
    "email": email,
    "mobile": mobile,
    "countryCode": countryCode,
    "password": password,
    "gender": gender,
    "nationality": nationality,
    "preferredLang": preferredLang,
    "device_token": deviceToken,
    "platform": platform,
  };
}
