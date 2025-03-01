import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct({required String productId}) {
    return false;
  }

  @override
  List<ProductEntity> getProducts() {
    return [];
  }
}
