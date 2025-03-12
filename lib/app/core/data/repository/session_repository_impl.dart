import 'package:storeapp/app/core/domain/datasource/session_datasource.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionDatasource sessionDatasource;

  SessionRepositoryImpl({required this.sessionDatasource});

  @override
  Future<bool> logout() async {
    return await sessionDatasource.logout();
  }
}
