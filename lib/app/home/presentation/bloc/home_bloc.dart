import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_event.dart';
import 'package:storeapp/app/home/presentation/bloc/home_state.dart';
import 'package:storeapp/app/home/presentation/model/product_model.dart';
import 'package:storeapp/app/util/log.util.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final String _tag = 'HomeBloc';
  final GetProductsUseCase getProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  HomeBloc({
    required this.getProductsUseCase,
    required this.deleteProductUseCase,
  }) : super(LoadingState()) {
    on<GetProductsEvent>(_getProductsEvent);
    on<DeleteProductEvent>(_deleteProductEvent);
  }

  Future<void> _getProductsEvent(
    GetProductsEvent event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;
    try {
      newState = LoadingState();
      emit(newState);
      final List<ProductModel> products = await getProductsUseCase.invoke();
      if (products.isEmpty) {
        newState = EmptyState();
        emit(newState);
      } else {
        newState = DataLoadedState(
          model: state.model.copyWith(
            products: products,
          ),
        );
        emit(newState);
      }
    } on Exception catch (e) {
      Log.d(_tag, 'Error obteniendo los productos: ${e.toString()}');
      newState = ErrorState(
        model: state.model,
        errorMessage: 'Error obteniendo los productos: ${e.toString()}',
      );
      emit(newState);
    }
  }

  Future<void> _deleteProductEvent(
    DeleteProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    late HomeState newState;
    try {
      newState = LoadingState();
      emit(newState);
      final bool success = await deleteProductUseCase.invoke(
        productId: event.productId,
      );
      if (success) {
        _getProductsEvent(GetProductsEvent(), emit);
      } else {
        Log.d(_tag, 'Error eliminando el producto');
        throw Exception();
      }
    } on Exception catch (e) {
      Log.d(_tag, 'Error eliminando el producto: ${e.toString()}');
      newState = ErrorState(
        model: state.model,
        errorMessage: 'Error eliminando el producto: ${e.toString()}',
      );
      emit(newState);
    }
  }
}
