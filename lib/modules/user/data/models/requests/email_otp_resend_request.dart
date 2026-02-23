class EmailOtpResendRequest {
  String? email;
  String? preferredLang;

  EmailOtpResendRequest({
    this.email,
    this.preferredLang,
  });

  factory EmailOtpResendRequest.fromJson(Map<String, dynamic> json) => EmailOtpResendRequest(
    email: json["email"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "preferredLang": preferredLang,
  };
}
