import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/data/datasource/session_firebase_datasource_impl.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/data/repository/session_repository_impl.dart';
import 'package:storeapp/app/core/domain/datasource/session_datasource.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/form_product/data/datasource/form_product_api_datasource_impl.dart';
import 'package:storeapp/app/form_product/data/repository/form_product_repository_impl.dart';
import 'package:storeapp/app/form_product/domain/datasource/form_product_api_datasource.dart';
import 'package:storeapp/app/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/get_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/home/data/datasource/home_api_datasource_impl.dart';
import 'package:storeapp/app/home/data/repository/home_repository_impl.dart';
import 'package:storeapp/app/home/domain/datasource/home_datasource.dart';
import 'package:storeapp/app/home/domain/repository/home_repository.dart';
import 'package:storeapp/app/home/domain/use_case/delete_products_use_case.dart';
import 'package:storeapp/app/home/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/home/presentation/bloc/home_bloc.dart';
import 'package:storeapp/app/login/data/datasource/login_firebase_datasource_impl.dart';
import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/datasource/login_datasource.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/signup/data/datasource/signup_firebase_datasource_impl.dart';
import 'package:storeapp/app/signup/data/respository/signup_repository_impl.dart';
import 'package:storeapp/app/signup/domain/datasource/signup_datasource.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/domain/use_case/create_user_use_case.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/user/data/datasource/user_api_datasource_impl.dart';
import 'package:storeapp/app/user/data/repository/user_repository_imp.dart';
import 'package:storeapp/app/user/domain/datasource/user_datasource.dart';
import 'package:storeapp/app/user/domain/repository/user_repository.dart';
import 'package:storeapp/app/user/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/user/presentation/bloc/user_bloc.dart';

final class DependencyInjection {
  DependencyInjection._();

  static final GetIt serviceLocator = GetIt.instance;

  static Future<void> setup({
    required FirebaseAuth instance,
    required SharedPreferences prefs,
  }) async {
    //SharedPreferences
    serviceLocator.registerSingleton<SharedPreferences>(prefs);

    //Firebase
    //+Authentication
    serviceLocator.registerSingleton<FirebaseAuth>(instance);

    //Service
    //+Dio
    serviceLocator.registerSingleton<Dio>(Dio());
    //+ProductService
    serviceLocator.registerFactory<ProductService>(
        () => ProductService(apiClient: serviceLocator.get()));
    //+UserService
    serviceLocator.registerFactory<UserService>(
        () => UserService(apiClient: serviceLocator.get()));

    //Feature
    //+core
    serviceLocator.registerFactory<SessionDatasource>(
      () => SessionFirebaseDatasourceImpl(
        prefs: serviceLocator.get(),
        firebaseAuth: serviceLocator.get(),
      ),
      instanceName: 'SessionFirebaseDatasourceImpl',
    );
/*    serviceLocator.registerFactory<SessionDatasource>(
      () => SessionLocalDatasourceImpl(prefs: serviceLocator.get()),
      instanceName: 'SessionLocalDatasourceImpl',
    );*/
    serviceLocator
        .registerFactory<SessionRepository>(() => SessionRepositoryImpl(
                sessionDatasource: serviceLocator.get(
              instanceName: 'SessionFirebaseDatasourceImpl',
            )));
    serviceLocator.registerFactory<LogoutUseCase>(
        () => LogoutUseCase(sessionRepository: serviceLocator.get()));

    //+Login
    serviceLocator.registerFactory<LoginDatasource>(
      () => LoginFirebaseDatasourceImpl(
        prefs: serviceLocator.get(),
        firebaseAuth: serviceLocator.get(),
      ),
      instanceName: 'LoginFirebaseDatasourceImpl',
    );
/*    serviceLocator.registerFactory<LoginDatasource>(
      () => LoginLocalDatasourceImpl(prefs: serviceLocator.get()),
      instanceName: 'LoginLocalDatasourceImpl',
    );*/
    serviceLocator.registerFactory<LoginRepository>(() => LoginRepositoryImpl(
            loginDatasource: serviceLocator.get(
          instanceName: 'LoginFirebaseDatasourceImpl',
        )));
    serviceLocator.registerFactory<LoginUseCase>(
        () => LoginUseCase(loginRepository: serviceLocator.get()));
    serviceLocator.registerFactory<LoginBloc>(
        () => LoginBloc(loginUseCase: serviceLocator.get()));

    //+Home
    serviceLocator.registerFactory<HomeDataSource>(
        () => HomeApiDatasourceImpl(productService: serviceLocator.get()));
    serviceLocator.registerFactory<HomeRepository>(() => HomeRepositoryImpl(
          homeDataSource: serviceLocator.get(),
        ));
    serviceLocator.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<DeleteProductsUseCase>(
        () => DeleteProductsUseCase(homeRepository: serviceLocator.get()));
    serviceLocator.registerFactory<HomeBloc>(() => HomeBloc(
        getProductsUseCase: serviceLocator.get(),
        deleteProductsUseCase: serviceLocator.get(),
        logoutUseCase: serviceLocator.get()));

    //+FormProduct
    serviceLocator.registerFactory<FormProductDatasource>(() =>
        FormProductApiDatasourceImpl(productService: serviceLocator.get()));
    serviceLocator.registerFactory<FormProductRepository>(() =>
        FormProductRepositoryImpl(formProductDatasource: serviceLocator.get()));
    serviceLocator.registerFactory<GetProductUseCase>(
        () => GetProductUseCase(formProductRepository: serviceLocator.get()));
    serviceLocator.registerFactory<AddProductUseCase>(
        () => AddProductUseCase(formProductRepository: serviceLocator.get()));
    serviceLocator.registerFactory<UpdateProductUseCase>(() =>
        UpdateProductUseCase(formProductRepository: serviceLocator.get()));
    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        getProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );

    //+Signup(register User)
    serviceLocator.registerFactory<SignupDatasource>(
      () => SignupFirebaseDatasourceImpl(
        userService: serviceLocator.get(),
        firebaseAuth: serviceLocator.get(),
      ),
      instanceName: 'SignupFirebaseDatasourceImpl',
    );
/*    serviceLocator.registerFactory<SignupDatasource>(
      () => SignupApiDatasourceImpl(userService: serviceLocator.get()),
      instanceName: 'SignupApiDatasourceImpl',
    );*/
    serviceLocator.registerFactory<SignupRepository>(() => SignUpRepositoryImpl(
            signupDatasource: serviceLocator.get(
          instanceName: 'SignupFirebaseDatasourceImpl',
        )));
    serviceLocator.registerFactory<CreateUserUseCase>(
        () => CreateUserUseCase(signupRepository: serviceLocator.get()));
    serviceLocator.registerFactory<SignupBloc>(
      () => SignupBloc(createUserUseCase: serviceLocator.get()),
    );

    //+User (User list)
    serviceLocator.registerFactory<UserDataSource>(
        () => UserApiDataSourceImp(userService: serviceLocator.get()));
    serviceLocator.registerFactory<UserRepository>(
        () => UserRepositoryImp(userDataSource: serviceLocator.get()));
    serviceLocator.registerFactory<GetUsersUseCase>(
        () => GetUsersUseCase(userRepository: serviceLocator.get()));
    serviceLocator.registerFactory<UserBloc>(
      () => UserBloc(
          getUsersUseCase: serviceLocator.get(),
          logoutUseCase: serviceLocator.get()),
    );
  }
}
