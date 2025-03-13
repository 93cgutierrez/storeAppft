import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/presentation/model/profile_model.dart';

class CreateUserUseCase {
  final SignUpRepository signUpRepository;

  CreateUserUseCase(this.signUpRepository);

  Future<bool> invoke({required ProfileModel profileModel}) async {
    try {
      final UserEntity data = profileModel.toUserEntity();
      return signUpRepository.createUser(data);
    } catch (e) {
      throw (Exception());
    }
  }
}
