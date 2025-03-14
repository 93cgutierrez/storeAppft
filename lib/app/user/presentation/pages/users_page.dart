import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/login/presentation/page/login_page.dart';
import 'package:storeapp/app/user/presentation/bloc/user_bloc.dart';
import 'package:storeapp/app/user/presentation/bloc/user_event.dart';
import 'package:storeapp/app/user/presentation/bloc/user_state.dart';
import 'package:storeapp/app/util/log.util.dart';

const String _tag = 'UsersPage';

class UsersPage extends StatefulWidget {
  static const String name = 'UsersPage';
  static const String link = '/$name';

  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: DependencyInjection.serviceLocator.get<UserBloc>(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              60.0,
            ),
            child: AppBarWidget(),
          ),
          body: UserListWidget(),
        ),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserBloc>();
    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        'Usuarios',
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context); // Navigate back
        },
      ),
      actions: [
        SizedBox(
          width: 4,
        ),
        IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Cerrar Sesión',
                ),
                content: Text(
                  '¿Estás seguro de cerrar sesión?',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      bloc.add(LogoutEvent());
                    },
                    child: const Text('Cerrar Sesión'),
                  )
                ],
              ),
            );
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 4,
        ),
      ],
    );
  }
}

class UserListWidget extends StatelessWidget {
  const UserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBloc bloc = context.read<UserBloc>();
    bloc.add(GetUsersEvent());
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        switch (state) {
          case UserInitial() ||
                UserEmptyState() ||
                UserLoadingState() ||
                UserLoadDataState():
            Log.d(_tag, 'Initial or Empty or loading or data loaded');
            break;
          case UserErrorState():
            Log.d(_tag, 'user error');
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Error',
                      ),
                      content: Text(
                        state.message.toString(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                            bloc.add(GetUsersEvent());
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ));
            break;
          case UserLogoutState():
            GoRouter.of(context).go(LoginPage.link);
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case UserLoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20.0,
                children: [
                  CircularProgressIndicator(),
                  Text(state.message),
                ],
              ),
            );
          case UserEmptyState():
            return Center(
              child: Text('No hay usuarios'),
            );
          case UserLoadDataState():
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columnas
              ),
              itemCount: state.model.users.length,
              itemBuilder: (context, index) {
                return UserItemWidget(
                  index: index,
                  user: state.model.users[index],
                );
              },
            );
          default:
            return Container();
        }
      },
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final int index;
  final UserDataModel user;

  const UserItemWidget({super.key, required this.index, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuario ${index + 1} seleccionado'),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(user.imageProfileUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.document,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
