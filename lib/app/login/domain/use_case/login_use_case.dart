import 'package:storeapp/app/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  late final LoginRepository _loginRepository;

  LoginUseCase() {
    _loginRepository = LoginRepositoryImpl();
  }

  bool invoke({required LoginFormModel loginFormModel}) {
    final LoginEntity entity = loginFormModel.toEntity();
    return _loginRepository.login(entity);
  }
}
