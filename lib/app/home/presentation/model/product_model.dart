import 'package:storeapp/app/core/domain/entity/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String urlImage;
  final double price;

  ProductModel({
    required this.id,
    required this.name,
    required this.urlImage,
    required this.price,
  });

  //toModel
  factory ProductModel.toModel(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      urlImage: entity.image,
      price: entity.price,
    );
  }
}
