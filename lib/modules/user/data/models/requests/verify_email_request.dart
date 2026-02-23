class VerifyEmailRequest {
  String? emailVerificationCode;
  String? email;
  String? preferredLang;

  VerifyEmailRequest({
    this.emailVerificationCode,
    this.email,
    this.preferredLang,
  });

  factory VerifyEmailRequest.fromJson(Map<String, dynamic> json) => VerifyEmailRequest(
    emailVerificationCode: json["email_verification_code"],
    email: json["email"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "email_verification_code": emailVerificationCode,
    "email": email,
    "preferredLang": preferredLang,
  };
}
