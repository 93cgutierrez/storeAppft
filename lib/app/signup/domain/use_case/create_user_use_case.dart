import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/signup/presentation/model/profile_model.dart';

class CreateUserUseCase {
  final SignupRepository signupRepository;

  CreateUserUseCase({required this.signupRepository});

  Future<bool> invoke({required ProfileModel profileModel}) async {
    final UserEntity data = profileModel.toUserEntity();
    return signupRepository.createUser(data);
  }
}
