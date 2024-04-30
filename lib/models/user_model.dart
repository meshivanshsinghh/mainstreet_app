class UserModel {
  String? userId;
  String? name;
  String? fcmToken;
  int? createdAt;
  String? profilePicture;
  String? email;
  String? bio;
  String? lat;
  String? long;

  UserModel(
      {this.userId,
      this.name,
      this.fcmToken,
      this.createdAt,
      this.profilePicture,
      this.email,
      this.bio,
      this.lat,
      this.long});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    fcmToken = json['fcm_token'];
    createdAt = json['createdAt'];
    profilePicture = json['profile_picture'];
    email = json['email'];
    bio = json['bio'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['fcm_token'] = this.fcmToken;
    data['createdAt'] = this.createdAt;
    data['profile_picture'] = this.profilePicture;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
