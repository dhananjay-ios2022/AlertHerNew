// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// The class represents the information of a product.
class SubscriptionDetailModel {
  String? id;
  String? title;
  String? description;
  String? price;
  double? rawPrice;
  String? currencyCode;
  String? currencySymbol;

  SubscriptionDetailModel({
     this.id,
     this.title,
     this.description,
     this.price,
     this.rawPrice,
     this.currencyCode,
    this.currencySymbol = '',
  });

  factory SubscriptionDetailModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionDetailModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    rawPrice: json["rawPrice"],
    currencyCode: json["currencyCode"],
    currencySymbol: json["currencySymbol"],
  );
  }

  Map<String, dynamic> toJson() {
    return {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "rawPrice": rawPrice,
    "currencyCode": currencyCode,
    "currencySymbol": currencySymbol,

  };
  }


}
