import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/util/log.util.dart';

class DeleteProductUseCase {
  static const String _tag = 'DeleteProductUseCase';
  final HomeRepository homeRepository;

  DeleteProductUseCase({required this.homeRepository});

  Future<bool> invoke({required String productId}) {
    try {
      return homeRepository.deleteProduct(productId: productId);
    } catch (e) {
      Log.e(_tag, e.toString());
      throw Exception('Error al eliminar el producto $e');
    }
  }
}
