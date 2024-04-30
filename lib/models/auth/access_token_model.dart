class AccessTokenModel {
  String? accessToken;
  String? tokenType;
  String? expiresAt;
  String? merchantId;
  String? refreshToken;
  bool? shortLived;

  AccessTokenModel(
      {this.accessToken,
      this.tokenType,
      this.expiresAt,
      this.merchantId,
      this.refreshToken,
      this.shortLived});

  AccessTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    merchantId = json['merchant_id'];
    refreshToken = json['refresh_token'];
    shortLived = json['short_lived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    data['merchant_id'] = this.merchantId;
    data['refresh_token'] = this.refreshToken;
    data['short_lived'] = this.shortLived;
    return data;
  }
}
