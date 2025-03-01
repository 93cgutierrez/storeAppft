import 'package:storeapp/app/home/presentation/model/product_model.dart';

class GetProductsUseCase {
  final ProductRespository;

  GetProductsUseCase({required this.productRepository});

  Future<List<ProductModel>> invoke() async {
    final List<ProductEntity> entities = await productRepository.getProducts();
    return entities.map((e) => e.toModel()).toList();
  }
}
