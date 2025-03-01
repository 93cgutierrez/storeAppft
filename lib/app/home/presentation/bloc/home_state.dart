import 'package:storeapp/app/home/presentation/model/home_model.dart';

sealed class HomeState {
  final HomeModel model;

  HomeState({
    required this.model,
  });
}

//empty state
final class EmptyState extends HomeState {
  EmptyState()
      : super(
          model: HomeModel(
            products: [],
          ),
        );
}

//loading state
final class LoadingState extends HomeState {
  final String message;
  LoadingState({
    this.message = 'Cargando...',
  }) : super(
          model: HomeModel(
            products: [],
          ),
        );
}

//load data state
final class DataLoadedState extends HomeState {
  DataLoadedState({
    required super.model,
  });
}

//error state
final class ErrorState extends HomeState {
  final String errorMessage;
  ErrorState({
    required super.model,
    required this.errorMessage,
  });
}
