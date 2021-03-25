import 'dart:convert';

FarmsData farmsDataFromJson(String str) => FarmsData.fromJson(json.decode(str));

String farmsDataToJson(FarmsData data) => json.encode(data.toJson());

class FarmsData {
  FarmsData({
    this.data,
    this.meta,
  });

  List<Data> data;
  Meta meta;

  factory FarmsData.fromJson(Map<String, dynamic> json) => FarmsData(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.type,
    this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    this.name,
    this.area,
    this.owner,
    this.hasPerenial,
    this.attributesDefault,
    this.latitude,
    this.imageUrls,
    this.longitude,
    this.productiveArea,
    this.farmGroupId,
    this.fieldExtrasAttributes,
    this.cultures,
    this.polygon,
  });

  String name;
  dynamic area;
  String owner;
  bool hasPerenial;
  bool attributesDefault;
  String latitude;
  List<dynamic> imageUrls;
  String longitude;
  String productiveArea;
  String farmGroupId;
  List<dynamic> fieldExtrasAttributes;
  List<Culture> cultures;
  List<dynamic> polygon;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        area: json["area"],
        owner: json["owner"],
        hasPerenial: json["has_perenial"],
        attributesDefault: json["default"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        imageUrls: List<dynamic>.from(json["image_urls"].map((x) => x)),
        longitude: json["longitude"] == null ? null : json["longitude"],
        productiveArea: json["productive_area"],
        farmGroupId: json["farm_group_id"],
        fieldExtrasAttributes:
            List<dynamic>.from(json["field_extras_attributes"].map((x) => x)),
        cultures: List<Culture>.from(
            json["cultures"].map((x) => Culture.fromJson(x))),
        polygon: List<dynamic>.from(json["polygon"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "area": area,
        "owner": owner,
        "has_perenial": hasPerenial,
        "default": attributesDefault,
        "latitude": latitude == null ? null : latitude,
        "image_urls": List<dynamic>.from(imageUrls.map((x) => x)),
        "longitude": longitude == null ? null : longitude,
        "productive_area": productiveArea,
        "farm_group_id": farmGroupId,
        "field_extras_attributes":
            List<dynamic>.from(fieldExtrasAttributes.map((x) => x)),
        "cultures": List<dynamic>.from(cultures.map((x) => x.toJson())),
        "polygon": List<dynamic>.from(polygon.map((x) => x)),
      };
}

class Culture {
  Culture({
    this.id,
    this.name,
    this.category,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String category;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  factory Culture.fromJson(Map<String, dynamic> json) => Culture(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "code": code,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Meta {
  Meta({
    this.totalPages,
    this.totalItems,
  });

  int totalPages;
  int totalItems;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "total_items": totalItems,
      };
}
