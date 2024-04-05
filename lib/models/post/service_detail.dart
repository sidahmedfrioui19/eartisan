class ServiceDetailEntity {
  final int serviceId;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final String userId;
  final int subcategoryId;
  final User user;
  final List<Picture> pictures;
  final List<Price> prices;

  ServiceDetailEntity({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.userId,
    required this.subcategoryId,
    required this.user,
    required this.pictures,
    required this.prices,
  });

  factory ServiceDetailEntity.fromJson(Map<String, dynamic> json) {
    return ServiceDetailEntity(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      subcategoryId: json['subcategory_id'],
      user: User.fromJson(json['user']),
      pictures: (json['pictures'] as List<dynamic>)
          .map((pictureJson) => Picture.fromJson(pictureJson))
          .toList(),
      prices: (json['prices'] as List<dynamic>)
          .map((priceJson) => Price.fromJson(priceJson))
          .toList(),
    );
  }
}

class User {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String role;
  final String phoneNumber;
  final String instagramLink;
  final String facebookLink;
  final String tiktokLink;
  final String profilePicture;

  User({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.role,
    required this.phoneNumber,
    required this.instagramLink,
    required this.facebookLink,
    required this.tiktokLink,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      role: json['role'],
      phoneNumber: json['phone_number'],
      instagramLink: json['instagram_link'],
      facebookLink: json['facebook_link'],
      tiktokLink: json['tiktok_link'],
      profilePicture: json['profile_picture'],
    );
  }
}

class Picture {
  final int pictureId;

  Picture({
    required this.pictureId,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
    );
  }
}

class Price {
  final int priceId;
  final String value;
  final String description;
  final String rate;

  Price({
    required this.priceId,
    required this.value,
    required this.description,
    required this.rate,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      priceId: json['price_id'],
      value: json['value'],
      description: json['description'],
      rate: json['rate'],
    );
  }
}
