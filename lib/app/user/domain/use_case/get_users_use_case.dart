import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/user/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase({required this.userRepository});

  Future<List<UserDataModel>> invoke() async {
    final List<UserDataModel> users = [];
    try {
      final List<UserEntity> result = await userRepository.getUsers();

      for (UserEntity element in result) {
        users.add(element.toUserDataModel());
      }
    } catch (e) {
      throw (Exception(e));
    }
    return users;
  }
}
