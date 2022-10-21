class UserModel {
  final String uid;
  final String name;
  final String token;
  final String major;
  final String createdAt;

  const UserModel(
      {required this.uid,
      required this.name,
      required this.token,
      required this.major,
      required this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        createdAt: json['createdAt'],
        token: json['token'],
        name: json['name'],
        major: json['major'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'token': token,
        'createdAt': createdAt,
        'name': name,
        'major': major,
      };
}
