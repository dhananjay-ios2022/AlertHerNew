class ChangePasswordRequest {
  String? password;
  String? newPassword;

  ChangePasswordRequest({
    this.password,
    this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(
    password: json["password"],
    newPassword: json["newPassword"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "newPassword": newPassword,
  };
}
