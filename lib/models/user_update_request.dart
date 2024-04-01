class UserUpdateEntity {
  String? firstname;
  String? lastname;
  String? address;
  String? phoneNumber;
  String? instagramLink;
  String? tiktokLink;
  String? facebookLink;
  String? profilePicture;
  bool? disponible;

  UserUpdateEntity({
    this.firstname,
    this.lastname,
    this.address,
    this.phoneNumber,
    this.instagramLink,
    this.tiktokLink,
    this.facebookLink,
    this.profilePicture,
    this.disponible,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'facebook_link': facebookLink,
      'profile_picture': profilePicture,
      'disponible': disponible,
    };
  }

  factory UserUpdateEntity.fromJson(Map<String, dynamic> json) {
    return UserUpdateEntity(
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      facebookLink: json['facebook_link'],
      profilePicture: json['profile_picture'],
      disponible: json['disponible'],
    );
  }
}
