import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';
import 'package:storeapp/app/util/log.util.dart';

class GetProductsUseCase {
  static const String _tag = 'GetProductsUseCase';
  final HomeRepository homeRepository;

  GetProductsUseCase({required this.homeRepository});

  Future<List<ProductModel>> invoke() async {
    try {
      final List<ProductEntity> entities = await homeRepository.getProducts();
      final List<ProductModel> models =
          entities.map((entity) => ProductModel.toModel(entity)).toList();
      return models;
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception(e);
    }
  }
}
