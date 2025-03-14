import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/user/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/user/presentation/bloc/user_event.dart';
import 'package:storeapp/app/user/presentation/bloc/user_state.dart';
import 'package:storeapp/app/util/log.util.dart';

const String _tag = 'UserBloc';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final LogoutUseCase logoutUseCase;

  UserBloc({
    required this.getUsersUseCase,
    required this.logoutUseCase,
  }) : super(UserInitial()) {
    on<GetUsersEvent>(_getUsersEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  Future<void> _getUsersEvent(
      GetUsersEvent event, Emitter<UserState> emit) async {
    late UserState newState;
    try {
      newState = UserLoadingState();
      emit(newState);

      final List<UserDataModel> result = await getUsersUseCase.invoke();

      if (result.isEmpty) {
        newState = UserEmptyState();
      } else {
        newState =
            UserLoadDataState(model: state.model.copyWith(users: result));
      }
    } catch (e) {
      Log.e(_tag, 'Error al obtener los usuarios $e');
      newState = UserErrorState(
          model: state.model, message: "Error al obtener los usuarios");
    }
    emit(newState);
  }

  void _logoutEvent(LogoutEvent event, Emitter<UserState> emit) {
    late UserState newState;
    try {
      logoutUseCase.invoke();
      newState = UserLogoutState();
      emit(newState);
    } catch (e) {
      Log.e(_tag, 'Error al cerrar sesión $e');
    }
  }
}
