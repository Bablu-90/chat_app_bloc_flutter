class UserModel {
  String id;
  String name;
  DateTime lastSeen;
  String email;
  String profilePicLink;

  UserModel(
      {required this.id,
      required this.name,
      required this.lastSeen,
      required this.email,
      required this.profilePicLink});


  //fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastSeen: json['lastSeen'],
      email: json['email'],
      profilePicLink: json['profilePicLink'],
    );
  }


//toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastSeen': lastSeen,
        'email': email,
        'profilePicLink': profilePicLink,
      };
}
