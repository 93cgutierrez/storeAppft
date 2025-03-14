import 'package:storeapp/app/core/domain/repository/session_repository.dart';

final class LogoutUseCase {
  final SessionRepository sessionRepository;

  LogoutUseCase({required this.sessionRepository});

  Future<bool> invoke() async {
    return await sessionRepository.logout();
  }
}
