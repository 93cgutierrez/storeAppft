import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class DeleteProductUseCase {
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  Future<bool> invoke({required String productId}) async {
    try {
      return await homeRepository.deleteProduct(productId: productId);
    } catch (e) {
      return false;
    }
  }
}
