import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/datasource/home_datasource.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl({required this.homeDataSource});

  @override
  Future<bool> deleteProduct(String id) {
    return homeDataSource.deleteProduct(id);
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    return await homeDataSource.getProducts();
  }
}
