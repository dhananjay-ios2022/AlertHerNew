class AddReviewRequest {
  String? countryCode;
  String? mobile;
  //String? clientName;
  String? description;
  int? flag;

  AddReviewRequest({
    this.countryCode,
    this.mobile,
  //  this.clientName,
    this.description,
    this.flag,
  });

  factory AddReviewRequest.fromJson(Map<String, dynamic> json) => AddReviewRequest(
    countryCode: json["countryCode"],
    mobile: json["mobile"],
   // clientName: json["clientName"],
    description: json["description"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "mobile": mobile,
 //   "clientName": clientName,
    "description": description,
    "flag": flag,
  };
}
