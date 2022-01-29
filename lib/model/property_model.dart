import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  PropertyModel({
    this.content,
    this.pageable,
    this.last,
    this.totalElements,
    this.totalPages,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  List<Content> content;
  Pageable pageable;
  bool last;
  int totalElements;
  int totalPages;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "pageable": pageable.toJson(),
        "last": last,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "size": size,
        "number": number,
        "sort": sort.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
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
    this.propertyImages,
    this.isFavourite,
  });

  int sqFeet;
  int bedrooms;
  int bathrooms;
  int garages;
  int price;
  String description;
  String address;
  List<PropertyImage> propertyImages;
  List<dynamic> isFavourite;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        sqFeet: json["sqFeet"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        garages: json["garages"],
        price: json["price"],
        description: json["description"],
        address: json["address"],
        propertyImages: List<PropertyImage>.from(
            json["propertyImages"].map((x) => PropertyImage.fromJson(x))),
        isFavourite: List<dynamic>.from(json["isFavourite"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sqFeet": sqFeet,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "garages": garages,
        "price": price,
        "description": description,
        "address": address,
        "propertyImages":
            List<dynamic>.from(propertyImages.map((x) => x.toJson())),
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

class Pageable {
  Pageable({
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  });

  Sort sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "sort": sort.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
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
