class PostEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String adress;
  final String phoneNumber;
  final String profilePicture;
  final String postId;
  final String title;
  final String description;
  final String status;

  PostEntity({
    required this.adress,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.postId,
    required this.profilePicture,
    required this.status,
    required this.title,
    required this.userId,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      adress: json['adress'],
      description: json['description'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phone_number'],
      postId: json['post_id'],
      profilePicture: json['profile_picture'],
      status: json['status'],
      title: json['title'],
      userId: json['user_id'],
    );
  }
}
