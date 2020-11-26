class User {
  String id;
  String email;
  String password;
  User();
  User.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    email = data['email'];
    password = data['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }
}
