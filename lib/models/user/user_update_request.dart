class UserUpdateEntity {
  String? firstname;
  String? lastname;
  String? address;
  String? phoneNumber;
  String? instagramLink;
  String? tiktokLink;
  String? facebookLink;
  String? profilePicture;
  int? available;
  int? category_id;
  String? cv;

  UserUpdateEntity({
    this.firstname,
    this.lastname,
    this.address,
    this.phoneNumber,
    this.instagramLink,
    this.tiktokLink,
    this.facebookLink,
    this.profilePicture,
    this.available,
    this.category_id,
    this.cv,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'adress': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'facebook_link': facebookLink,
      'profile_picture': profilePicture,
      'disponible': available,
      'category_id': category_id,
      'cv': cv ?? '',
    };
  }

  factory UserUpdateEntity.fromJson(Map<String, dynamic> json) {
    return UserUpdateEntity(
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['adress'],
      phoneNumber: json['phone_number'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      facebookLink: json['facebook_link'],
      profilePicture: json['profile_picture'],
      available: json['disponible'],
    );
  }
}
