import 'dart:convert';

import 'package:dumper/model/fav_house_model.dart';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  PropertyModel({
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  List<Content> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  Sort sort;
  int numberOfElements;
  bool first;
  bool empty;

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        numberOfElements: json["numberOfElements"],
        first: json["first"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "numberOfElements": numberOfElements,
        "first": first,
        "empty": empty,
      };
}

class Content {
  Content({
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
  bool isFav;
  Seller user;
  int id;
  List<PropertyImage> propertyImages;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        sqFeet: json["sqFeet"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        garages: json["garages"],
        price: json["price"],
        description: json["description"],
        address: json["address"],
        isFav: json["isFav"],
        user: Seller.fromJson(json["user"]),
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

  static Content mapHouseData(Property data) {
    Content newData = Content();
    newData.address = data.address;
    newData.bathrooms = data.bathrooms;
    newData.garages = data.garages;
    newData.price = data.price;
    newData.description = data.description;
    newData.sqFeet = data.sqFeet;
    newData.bedrooms = data.bedrooms;
    newData.isFav = true;
    // Seller
    Seller seller = Seller();
    seller.email = data.user.email;
    seller.firstName = data.user.firstName;
    seller.lastName = data.user.lastName;
    seller.username = data.user.username;
    seller.roles = data.user.roles;
    //
    newData.user = seller;
    newData.id = data.id;
    List<PropertyImage> imageList = [];
    for (int i = 0; i < data.propertyImages.length; i++) {
      PropertyImage propertyImage = PropertyImage();
      propertyImage.name = data.propertyImages[i].name;
      propertyImage.path = data.propertyImages[i].path;
      propertyImage.contentType = data.propertyImages[i].contentType;
      imageList.add(propertyImage);
    }
    newData.propertyImages = imageList;
    return newData;
  }
}

class PropertyImage {
  PropertyImage({
    this.path,
    this.contentType,
    this.name,
  });

  String path;
  dynamic contentType;
  dynamic name;

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

class Seller {
  Seller({
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
  dynamic roles;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        roles: json["roles"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username,
        "roles": roles,
      };
}

class Pageable {
  Pageable({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.unpaged,
    this.paged,
  });

  Sort sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool unpaged;
  bool paged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        unpaged: json["unpaged"],
        paged: json["paged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "unpaged": unpaged,
        "paged": paged,
      };
}

class Sort {
  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  bool empty;
  bool sorted;
  bool unsorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}
