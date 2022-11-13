import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.roles,
  });

  String firstName;
  String lastName;
  String email;
  String username;
  List<Role> roles;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    username: json["username"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "username": username,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    this.name,
  });

  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
