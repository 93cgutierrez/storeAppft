import 'package:storeapp/app/core/domain/entity/product_entity.dart';

class ProductDataModel {
  final String id;
  late final String name;
  late final String imageUrl;
  late final double price;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  //fromJson
  ProductDataModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['image'];
    price = json['price'] is int
        ? (json['price'] as int).toDouble()
        : json['price'].toDouble();
  }

  //toEntity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      image: imageUrl,
      price: price,
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
      'price': price.toStringAsFixed(2),
    };
  }
}
