import 'dart:convert';

SingleProperty singlePropertyFromJson(String str) => SingleProperty.fromJson(json.decode(str));

String singlePropertyToJson(SingleProperty data) => json.encode(data.toJson());

class SingleProperty {
  SingleProperty({
    this.id,
    this.sqFeet,
    this.bedrooms,
    this.bathrooms,
    this.garages,
    this.price,
    this.description,
    this.address,
    this.propertyImages,
    this.isFavourite,
  });

  int id;
  int sqFeet;
  int bedrooms;
  int bathrooms;
  int garages;
  int price;
  String description;
  String address;
  List<PropertyImage> propertyImages;
  List<dynamic> isFavourite;

  factory SingleProperty.fromJson(Map<String, dynamic> json) => SingleProperty(
    id: json["id"],
    sqFeet: json["sqFeet"],
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    garages: json["garages"],
    price: json["price"],
    description: json["description"],
    address: json["address"],
    propertyImages: List<PropertyImage>.from(json["propertyImages"].map((x) => PropertyImage.fromJson(x))),
    isFavourite: List<dynamic>.from(json["isFavourite"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sqFeet": sqFeet,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "garages": garages,
    "price": price,
    "description": description,
    "address": address,
    "propertyImages": List<dynamic>.from(propertyImages.map((x) => x.toJson())),
    "isFavourite": List<dynamic>.from(isFavourite.map((x) => x)),
  };
}

class PropertyImage {
  PropertyImage({
    this.path,
    this.contentType,
    this.name,
    this.size,
  });

  String path;
  String contentType;
  String name;
  int size;

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
    path: json["path"],
    contentType: json["contentType"],
    name: json["name"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "contentType": contentType,
    "name": name,
    "size": size,
  };
}
