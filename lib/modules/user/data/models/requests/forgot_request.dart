class ForgotRequest {
  String? email;
  String? preferredLang;

  ForgotRequest({
    this.email,
    this.preferredLang,
  });

  factory ForgotRequest.fromJson(Map<String, dynamic> json) => ForgotRequest(
    email: json["email"],
    preferredLang: json["preferredLang"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "preferredLang": preferredLang,
  };
}