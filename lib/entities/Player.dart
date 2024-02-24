class Player {
  String? playername;
  String email;
  String? token;

  Player(this.playername, this.email, this.token);
  factory Player.fromemail(email) {
    return Player(null, email, null);
  }
}

Player player = Player(null, "", "");
