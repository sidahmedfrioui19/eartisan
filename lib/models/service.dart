class ServiceEntity {
  final int serviceId;
  final String title;
  final String description;
  final User user;
  final List<Picture> pictures;
  final List<Price> prices;

  ServiceEntity({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.user,
    required this.pictures,
    required this.prices,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
    return ServiceEntity(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
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
  final String? address;
  final String? phoneNumber;
  final String? profilePic;
  final int available;

  User({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.available,
    this.address,
    this.phoneNumber,
    this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json['user_id'],
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        address: json['address'],
        phoneNumber: json['phone_number'],
        profilePic: json['profile_pic'],
        available: json['available']);
  }
}

class Picture {
  final int pictureId;
  final String link;

  Picture({
    required this.pictureId,
    required this.link,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
      link: json['link'],
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
