class MerchantModel {
  Merchant? merchant;

  MerchantModel({this.merchant});

  MerchantModel.fromJson(Map<String, dynamic> json) {
    merchant = json['merchant'] != null
        ? new Merchant.fromJson(json['merchant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.merchant != null) {
      data['merchant'] = this.merchant!.toJson();
    }
    return data;
  }
}

class Merchant {
  String? id;
  String? businessName;
  String? country;
  String? languageCode;
  String? currency;
  String? status;
  String? mainLocationId;
  String? createdAt;
  String? shopPicture;
  String? lat;
  String? long;

  Merchant(
      {this.id,
      this.shopPicture,
      this.businessName,
      this.country,
      this.languageCode,
      this.lat,
      this.long,
      this.currency,
      this.status,
      this.mainLocationId,
      this.createdAt});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    country = json['country'];
    languageCode = json['language_code'];
    currency = json['currency'];
    shopPicture = json['shop_picture'];
    status = json['status'];
    mainLocationId = json['main_location_id'];
    createdAt = json['created_at'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['country'] = this.country;
    data['language_code'] = this.languageCode;
    data['currency'] = this.currency;
    data['shop_picture'] = this.shopPicture;
    data['status'] = this.status;
    data['main_location_id'] = this.mainLocationId;
    data['created_at'] = this.createdAt;
    data['lat'] = this.lat;
    data['long'] = this.long;

    return data;
  }
}
