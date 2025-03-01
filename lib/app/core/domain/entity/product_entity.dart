import 'package:storeapp/app/home/presentation/model/product_model.dart';

class ProductEntity {
  final String id;
  final String name;
  final String image;
  final double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
  });

  //toProductModel
  static ProductModel toModel(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      urlImage: entity.image,
      price: entity.price,
    );
  }
}
