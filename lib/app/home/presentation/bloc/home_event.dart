sealed class HomeEvent {}

final class GetProductsEvent extends HomeEvent {
  GetProductsEvent();
}

//DeleteProductEvent
final class DeleteProductEvent extends HomeEvent {
  final String productId;
  DeleteProductEvent({
    required this.productId,
  });
}
