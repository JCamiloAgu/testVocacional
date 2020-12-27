class User {
  static final _instance = User._internal();

  factory User() {
    return _instance;
  }

  User._internal();

  int id;
  String fullName;
  String email;
  int age;
  String gender;
}
