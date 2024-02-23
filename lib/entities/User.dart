class User {
  String? username;
  String email;
  String? token;

  User(this.username, this.email, this.token);
  factory User.fromemail(email) {
    return User(null, email, null);
  }
}

User user = User(null, "", "");
