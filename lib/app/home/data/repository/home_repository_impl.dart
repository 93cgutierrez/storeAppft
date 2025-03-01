import 'package:storeapp/app/core/domain/entity/product_entity.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  bool deleteProduct({required String productId}) {
    return false;
  }

  @override
  List<ProductEntity> getProducts() {
    return [
      ProductEntity(
        id: '1',
        name: 'Producto 1',
        image: 'https://picsum.photos/600/700?random=1',
        price: 10.0,
      ),
      ProductEntity(
        id: '2',
        name: 'Producto 2',
        image: 'https://picsum.photos/600/700?random=2',
        price: 20.0,
      ),
      ProductEntity(
        id: '3',
        name: 'Producto 3',
        image: 'https://picsum.photos/600/700?random=3',
        price: 30.0,
      ),
      ProductEntity(
        id: '4',
        name: 'Producto 4',
        image: 'https://picsum.photos/600/700?random=4',
        price: 40.0,
      ),
      ProductEntity(
        id: '5',
        name: 'Producto 5',
        image: 'https://picsum.photos/600/700?random=5',
        price: 50.0,
      ),
      ProductEntity(
        id: '6',
        name: 'Producto 6',
        image: 'https://picsum.photos/600/700?random=6',
        price: 60.0,
      ),
      ProductEntity(
        id: '7',
        name: 'Producto 7',
        image: 'https://picsum.photos/600/700?random=7',
        price: 70.0,
      ),
      ProductEntity(
        id: '8',
        name: 'Producto 8',
        image: 'https://picsum.photos/600/700?random=8',
        price: 80.0,
      ),
      ProductEntity(
        id: '9',
        name: 'Producto 9',
        image: 'https://picsum.photos/600/700?random=9',
        price: 90.0,
      ),
      ProductEntity(
        id: '10',
        name: 'Producto 10',
        image: 'https://picsum.photos/600/700?random=10',
        price: 100.0,
      ),
    ];
  }
}
