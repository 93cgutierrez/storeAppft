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

  //toEntity
  ProductEntity toEntity(ProductModel model) {
    return ProductEntity(
      id: model.id,
      name: model.name,
      image: model.urlImage,
      price: model.price,
    );
  }

  static ProductModel toModel(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      urlImage: entity.image,
      price: entity.price,
    );
  }
}
