import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/home/data/repository/home_repository_impl.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';

final class DependencyInjection {
  DependencyInjection._();

  static final GetIt serviceLocator = GetIt.instance;

  static void setup() {
    //Service
    //+Dio
    serviceLocator.registerSingleton<Dio>(Dio());
    //+ProductService
    serviceLocator.registerFactory<ProductService>(
        () => ProductService(apiClient: serviceLocator.get()));

    //Feature
    //+Login
    serviceLocator
        .registerFactory<LoginRepository>(() => LoginRepositoryImpl());
    serviceLocator.registerFactory<LoginUseCase>(
        () => LoginUseCase(loginRepository: serviceLocator.get()));
    serviceLocator.registerFactory<LoginBloc>(
        () => LoginBloc(loginUseCase: serviceLocator.get()));
    //-Home
    serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
          productService: serviceLocator.get(),
        ));
    serviceLocator.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<DeleteProductUseCase>(
        () => DeleteProductUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<HomeBloc>(() => HomeBloc(
          getProductsUseCase: serviceLocator.get(),
          deleteProductUseCase: serviceLocator.get(),
        ));
  }
}
