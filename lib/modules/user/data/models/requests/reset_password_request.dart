class ResetPasswordRequest {
  String? password;
  String? email;
  int? OTP;
  String? preferredLang;

  ResetPasswordRequest({
    this.password,
    this.email,
    this.OTP,
    this.preferredLang,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
    password: json["password"],
    email: json["email"],
    OTP: json["OTP"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "OTP": OTP,
    "email": email,
    "preferredLang": preferredLang,
  };
}
