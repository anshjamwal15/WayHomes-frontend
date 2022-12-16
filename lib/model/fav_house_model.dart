import 'dart:convert';

List<FavHouseModel> favHouseModelFromJson(String str) =>
    List<FavHouseModel>.from(
        json.decode(str).map((x) => FavHouseModel.fromJson(x)));

String favHouseModelToJson(List<FavHouseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavHouseModel {
  FavHouseModel({
    this.property,
    this.users,
  });

  Property property;
  User users;

  factory FavHouseModel.fromJson(Map<String, dynamic> json) => FavHouseModel(
        property: Property.fromJson(json["property"]),
        users: User.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "property": property.toJson(),
        "users": users.toJson(),
      };
}

class Property {
  Property({
    this.sqFeet,
    this.bedrooms,
    this.bathrooms,
    this.garages,
    this.price,
    this.description,
    this.address,
    this.isFav,
    this.user,
    this.id,
    this.propertyImages,
  });

  int sqFeet;
  int bedrooms;
  int bathrooms;
  int garages;
  int price;
  String description;
  String address;
  dynamic isFav;
  User user;
  int id;
  List<PropertyImage> propertyImages;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        sqFeet: json["sqFeet"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        garages: json["garages"],
        price: json["price"],
        description: json["description"],
        address: json["address"],
        isFav: json["isFav"],
        user: User.fromJson(json["user"]),
        id: json["id"],
        propertyImages: List<PropertyImage>.from(
            json["propertyImages"].map((x) => PropertyImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sqFeet": sqFeet,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "garages": garages,
        "price": price,
        "description": description,
        "address": address,
        "isFav": isFav,
        "user": user.toJson(),
        "id": id,
        "propertyImages":
            List<dynamic>.from(propertyImages.map((x) => x.toJson())),
      };
}

class PropertyImage {
  PropertyImage({
    this.path,
    this.contentType,
    this.name,
  });

  String path;
  String contentType;
  String name;

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        path: json["path"],
        contentType: json["contentType"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "contentType": contentType,
        "name": name,
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.roles,
  });

  dynamic firstName;
  dynamic lastName;
  String email;
  String username;
  List<Role> roles;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
