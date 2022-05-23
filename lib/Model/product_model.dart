import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.productItems,
  });

  List<ProductItem>? productItems;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productItems: json["product_items"] == null
            ? null
            : List<ProductItem>.from(
                json["product_items"].map((x) => ProductItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_items": productItems == null
            ? null
            : List<dynamic>.from(productItems!.map((x) => x.toJson())),
      };
}

class ProductItem {
  ProductItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  int id;
  String name;
  String imageUrl;
  double price;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductItem &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          price == other.price;

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"]! == null ? null : json["id"],
        name: json["name"]! == null ? null : json["name"],
        imageUrl: json["image_url"]! == null ? null : json["image_url"],
        price: json["price"]! == null ? null : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image_url": imageUrl == null ? null : imageUrl,
        "price": price == null ? null : price,
      };
}
