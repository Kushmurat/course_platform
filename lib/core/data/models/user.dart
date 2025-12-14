class User {
  final int? id;
  final String email;
  final String? username;
  final String token;

  User({this.id, required this.email, this.username, required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      email: json['email'] ?? '',
      username: json['username'],
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'username': username, 'token': token};
  }
}
