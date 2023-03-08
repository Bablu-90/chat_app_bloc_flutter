class UserModel {

  String id;
  String name;
  DateTime lastSeen;
  bool active;
  String email;


  UserModel(
      {
      required this.id,
      required this.name,
      required this.lastSeen,
      required this.email,
      required this.active
      });


  //fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      lastSeen: json['lastSeen'],
      email: json['email'],

    );
  }


//toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastSeen': lastSeen,
        'email': email,
        'active': active,
      };
}
